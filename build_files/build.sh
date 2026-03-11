#!/usr/bin/env bash

echo "=== EC-Fan-Control für Bosgame M5 wird installiert ==="

dnf install -y git make gcc kernel-devel kernel-headers

git clone https://github.com/cmetz/ec-su_axb35-linux.git /tmp/ec-driver
cd /tmp/ec-driver
make

mkdir -p /usr/lib/modules/$(uname -r)/extra
cp ec_su_axb35.ko /usr/lib/modules/$(uname -r)/extra/

echo "ec_su_axb35" > /etc/modules-load.d/ec-su_axb35.conf

rm -rf /tmp/ec-driver
echo "=== EC-Treiber erfolgreich integriert ==="
