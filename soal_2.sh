#!/bin/bash
# Soal 2: Konfigurasi Internet untuk Eru

echo ">>> Mengkonfigurasi eth0 untuk DHCP..."

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface (ke Internet)
auto eth0
iface eth0 inet dhcp
EOF


echo ">>> Coba ping ke google.com"
ping -c 5 google.com