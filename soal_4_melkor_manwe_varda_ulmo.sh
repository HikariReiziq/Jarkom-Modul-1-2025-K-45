#!/bin/bash
# Soal 4 - Bagian Client: Konfigurasi DNS dan Tes Koneksi

# Masukkan IP DNS yang Anda dapatkan dari Eru di sini
DNS_SERVER="192.168.122.1"

echo ">>> Mengatur DNS Server menjadi $DNS_SERVER..."
echo "nameserver $DNS_SERVER" > /etc/resolv.conf

echo ">>> Konfigurasi DNS baru:"
cat /etc/resolv.conf
echo ""

echo ">>> Melakukan tes ping ke google.com..."
ping -c 5 google.com