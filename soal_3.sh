#!/bin/bash
# Soal 3: Konfigurasi IP Statis untuk Eru

echo ">>> Menambahkan konfigurasi IP statis untuk eth1 dan eth2..."

vm# Interface ke Switch 1
auto eth1
iface eth1 inet static
    address 10.86.1.1
    netmask 255.255.255.0

# Interface ke Switch 2
auto eth2
iface eth2 inet static
    address 10.86.2.1
    netmask 255.255.255.0

echo ">>> Menampilkan konfigurasi IP baru"
ip a