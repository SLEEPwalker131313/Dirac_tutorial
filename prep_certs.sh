#!/bin/bash
cd /home/dirac/Tutorial
./make_CA
./make_host spbudirac.jinr.ru
./make_user "Vadim Petrunin" petrunin-vn@yandex.ru
mkdir -p /home/dirac/.globus
mkdir -p /opt/dirac/.globus
cp user* /home/dirac/.globus
cp user* /home/dirac/.globus
cp host* /etc/grid-security
cp host* /opt/dirac/etc/grid-security
cp ca* /etc/grid-security/certificates
chown -R dirac:dirac /home/dirac
chown -R dirac:dirac /opt/dirac
