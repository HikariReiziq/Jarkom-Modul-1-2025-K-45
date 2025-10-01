#!/bin/bash
# Soal 2: Konfigurasi Internet untuk Eru

echo ">>> Mengkonfigurasi eth0 untuk DHCP..."

# Menulis konfigurasi baru ke /etc/network/interfaces
cat <<EOF > /etc/network/interfaces
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface (ke Internet)
auto eth0
iface eth0 inet dhcp
EOF

echo ">>> Konfigurasi selesai. Restart interface jaringan..."
/etc/init.d/networking restart

echo ">>> Coba ping ke google.com"
ping -c 5 google.com