#!/usr/bin/env bash
set -e

echo "=== EC-Fan-Control für Bosgame M5 wird installiert ==="

# Wichtige Abhängigkeiten + Kernel-Headers für den aktuellen Kernel
dnf install -y git make gcc kernel-devel kernel-headers dnf-plugins-core

# Treiber herunterladen und bauen
git clone https://github.com/cmetz/ec-su_axb35-linux.git /tmp/ec-driver
cd /tmp/ec-driver
make -j$(nproc)

# Modul ins Image kopieren
mkdir -p /usr/lib/modules/$(uname -r)/extra
cp ec_su_axb35.ko /usr/lib/modules/$(uname -r)/extra/

# Automatisch laden beim Boot
echo "ec_su_axb35" > /etc/modules-load.d/ec-su_axb35.conf

# Aufräumen
cd /
rm -rf /tmp/ec-driver

echo "=== EC-Treiber erfolgreich integriert ==="
