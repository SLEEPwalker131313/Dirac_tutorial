#!/bin/bash
wget http://repository.egi.eu/sw/production/cas/1/current/repo-files/EGI-trustanchors.repo -O /etc/yum.repos.d/EGI-trustanchors.repo

iptables -I INPUT -p tcp --dport 9130:9200 -j ACCEPT
iptables -I INPUT -p tcp --dport 3306 -j ACCEPT
iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080
iptables -t nat -I PREROUTING -p tcp --dport 443 -j REDIRECT --to-ports 8443
service iptables save

yum -y install git
yum -y install tree
yum -y install telnet

wget dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
rpm -ihv epel-release-7-11.noarch.rpm
yum -y install htop

git clone https://github.com/SLEEPwalker131313/Dirac_tutorial
adduser -s /bin/bash -d /home/dirac dirac
mkdir -p /home/dirac/Tutorial
mkdir /opt/dirac
cp Dirac_tutorial/* /home/dirac/Tutorial

chown -R dirac:dirac /opt/dirac


cat > /etc/yum.repos.d/egi-trustanchors.repo << EOF
[EGI-trustanchors]
name=EGI-trustanchors
baseurl=http://repository.egi.eu/sw/production/cas/1/current/
gpgkey=http://repository.egi.eu/sw/production/cas/1/GPG-KEY-EUGridPMA-RPM-3
gpgcheck=1
enabled=1
EOF
yum -y install ca-policy-egi-core

cat > /etc/yum.repos.d/fetch-crl.repo << EOF
[EUGRIDPMA-fetch-crl]
name=EUGRIDPMA fetch-crl repository
baseurl=https://dist.eugridpma.info/distribution/util/fetch-crl3/
enabled=1
metadata_expire=300
gpgcheck=0
EOF
yum -y install fetch-crl
chkconfig fetch-crl-cron on
service fetch-crl-cron start

yum -y install lcg-CA

mkdir -p /opt/dirac/etc/grid-security/
cd /opt/dirac/etc/grid-security/
ln -s /etc/grid-security/certificates/ .
chown -R dirac:dirac /opt/dirac
