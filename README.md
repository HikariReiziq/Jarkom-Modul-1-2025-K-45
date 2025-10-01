# Laporan Praktikum Modul 1: 

| Nama Lengkap                        | NIM         | Kelas |
|------------------------------------|-------------|-------|
| M. Hikari Reizqi Rakhmadinta       | 5022141079  | K-45  |
| MADE GDE KRISNA WANGSA             | 502201047   | -     |

- **Kelompok**: K-45
- **Prefix IP**: 10.86

---

## Tahap Awal: Setup GNS3 dan Akses Node
Sebelum memulai pengerjaan, langkah pertama adalah menghubungkan GNS3 Client ke *remote server* dan memastikan kita bisa mengakses konsol dari setiap *node*.

1.  **Koneksi ke Remote Server GNS3**
    Saat GNS3 Client dibuka, pilih opsi untuk terhubung ke *remote controller* dan masukkan kredensial yang telah diberikan oleh asisten.

2.  **Instalasi Telnet Client**
    Untuk mengakses konsol *node* dari GNS3, kita membutuhkan Telnet client. Pada sistem operasi basis Debian (seperti Kali Linux), instalasi dapat dilakukan dengan perintah `sudo apt install telnet`.
    ![insert-image-1](images/soal1-5_2.png)

3.  **Akses Konsol Node**
    Setelah Telnet client terinstal, kita bisa mengakses konsol dari setiap *node* untuk melakukan konfigurasi.
    ![insert-image-2](images/soal1-5_3.png)

---

## Soal 1: Membuat Topologi Jaringan
Soal pertama adalah membuat topologi jaringan dasar sesuai skenario yang diberikan, di mana **Eru** berperan sebagai *Router* yang menghubungkan dua jaringan terpisah.

Topologi akhir yang dibuat adalah sebagai berikut:
![insert-image-3](images/soal1-5_5.png)

---

## Soal 2 & 3: Konfigurasi IP Address dan Konektivitas Lokal
Setelah topologi dibuat, langkah selanjutnya adalah mengkonfigurasi alamat IP statis untuk setiap *node* agar dapat berkomunikasi dalam jaringan lokalnya masing-masing. Konfigurasi dilakukan melalui menu **Edit network configuration** pada setiap *node*.

Berikut adalah konfigurasi yang diterapkan:

-   **Eru (Router)**
    ```
    auto eth0
    iface eth0 inet dhcp

    auto eth1
    iface eth1 inet static
        address 10.86.1.1
        netmask 255.255.255.0

    auto eth2
    iface eth2 inet static
        address 10.86.2.1
        netmask 255.255.255.0
    ```

-   **Melkor (Client)**
    ```
    auto eth0
    iface eth0 inet static
        address 10.86.1.2
        netmask 255.255.255.0
        gateway 10.86.1.1
    ```

-   **Manwe (Client)**
    ```
    auto eth0
    iface eth0 inet static
        address 10.86.1.3
        netmask 255.255.255.0
        gateway 10.86.1.1
    ```

-   **Varda (Client)**
    ```
    auto eth0
    iface eth0 inet static
        address 10.86.2.2
        netmask 255.255.255.0
        gateway 10.86.2.1
    ```

-   **Ulmo (Client)**
    ```
    auto eth0
    iface eth0 inet static
        address 10.86.2.3
        netmask 255.255.255.0
        gateway 10.86.2.1
    ```

Setelah semua *node* di-*restart*, dilakukan pengecekan IP pada *node* Eru menggunakan perintah `ip a` untuk memastikan konfigurasi telah berhasil diterapkan.
![insert-image-4](images/soal1-5_6.png)

---

## Soal 4: Menghubungkan Semua Node ke Internet
Agar *client* dapat terhubung ke internet, *router* Eru harus dikonfigurasi untuk melakukan **NAT (Network Address Translation)**.

1.  **Menghubungkan Router Eru ke Internet**
    Pertama, *node* Eru dihubungkan ke *node* NAT bawaan GNS3. Setelah interfacenya diatur sebagai DHCP, Eru berhasil terhubung ke internet, dibuktikan dengan `ping google.com`.
    ![insert-image-5](images/soal1-5_4.png)

2.  **Konfigurasi Iptables untuk NAT Masquerade**
    Agar paket dari *client* bisa diteruskan ke internet, digunakan `iptables` untuk menyamarkan alamat IP *source* menjadi alamat IP *router*.
    - Awalnya, perintah `iptables` tidak ditemukan.
      ![insert-image-6](images/soal1-5_7.png)
    - Maka, dilakukan instalasi `iptables` terlebih dahulu pada *node* Eru.
      ![insert-image-7](images/soal1-5_8.png)
    - Setelah terinstal, aturan NAT `MASQUERADE` berhasil ditambahkan.
      ![insert-image-8](images/soal1-5_9.png)

---

## Soal 5: Konfigurasi DNS pada Client
Langkah terakhir adalah memastikan semua *client* mengetahui alamat DNS Server yang harus digunakan.

1.  **Mencari Alamat DNS Server**
    Alamat DNS Server didapatkan dengan melihat file `/etc/resolv.conf` pada *router* Eru yang sudah terhubung ke internet.
    ![insert-image-9](images/soal1-5_9.png)

2.  **Menerapkan Konfigurasi DNS pada Client**
    Alamat IP DNS yang didapat (dalam kasus ini `192.168.122.1`) kemudian dituliskan ke dalam file `/etc/resolv.conf` di semua *node client* (Melkor, Manwe, Varda, Ulmo) menggunakan perintah `echo nameserver 192.168.122.1 > /etc/resolv.conf`.

Setelah langkah ini, semua *node* dalam topologi berhasil terhubung ke internet.
