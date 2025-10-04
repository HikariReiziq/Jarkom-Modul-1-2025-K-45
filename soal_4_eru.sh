#!/bin/bash
# Soal 4 - Bagian Eru: Konfigurasi NAT dan Mencari DNS

echo ">>> Menginstall iptables..."
apt update && apt install iptables -y

echo ">>> Menambahkan aturan NAT MASQUERADE..."
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.86.0.0/16

echo "---------------------------------------------------------"
echo ">>> Konfigurasi NAT selesai."
echo ">>> Menampilkan IP DNS Server dari Eru (catat IP ini):"
cat /etc/resolv.conf
echo "---------------------------------------------------------"