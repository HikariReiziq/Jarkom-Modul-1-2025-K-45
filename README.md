# Laporan Praktikum Modul 1: 

| Nama Lengkap                        | NIM         |
|------------------------------------|-------------|
| M. Hikari Reizqi Rakhmadinta       | 5027241079  |
| MADE GDE KRISNA WANGSA             | 5027201047  |

- **Kelompok**: K-45
- **Prefix IP**: 10.86

Laporan ini mendokumentasikan proses pengerjaan soal 1 hingga 4, mulai dari setup topologi sederhana hingga memberikan akses internet ke semua *node client*.

---

## 1. Setup Awal dan Konektivitas Router
Tahap awal adalah membangun topologi sederhana untuk menghubungkan **Router Eru** ke internet dan memastikan akses konsol dapat dilakukan.

-   **Membuat Topologi Sederhana**
    Topologi awal terdiri dari *node* NAT yang terhubung ke *node* Debian (yang nantinya akan menjadi Router Eru).
    ![insert-image-1](images/soal1-5_1.png)

-   **Instalasi Telnet Client**
    Untuk mengakses konsol GNS3, Telnet client diinstall terlebih dahulu pada WSL.
    ![insert-image-2](images/soal1-5_2.png)

-   **Menguji Akses Konsol**
    Setelah instalasi, koneksi ke konsol *node* di GNS3 berhasil dilakukan.
    ![insert-image-3](images/soal1-5_3.png)

-   **Menguji Koneksi Internet Router (Eru)**
    Dengan mengaktifkan DHCP client pada *interface* yang terhubung ke NAT, Router Eru berhasil mendapatkan koneksi internet, dibuktikan dengan `ping google.com`.
    ![insert-image-4](images/soal1-5_4.png)

---

## 2. Soal 1: Melengkapi Topologi Jaringan
Sesuai soal, topologi kemudian dilengkapi dengan dua *switch* dan empat *client* (Melkor, Manwe, Varda, dan Ulmo).
![insert-image-5](images/soal1-5_5.png)

---

## 3. Soal 2 & 3: Konfigurasi Alamat IP
Selanjutnya, alamat IP statis diatur untuk semua *node* agar dapat berkomunikasi di jaringan lokal.

-   **Eru (Router)**
    ```
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
Pengecekan pada Eru menggunakan `ip a` menunjukkan semua *interface* telah terkonfigurasi dengan benar.
![insert-image-6](images/soal1-5_6.png)

---

## 4. Soal 4: Memberikan Akses Internet untuk Client
Langkah terakhir adalah mengkonfigurasi Eru agar dapat meneruskan koneksi internet ke semua *client*.

-   **Konfigurasi Iptables (NAT)**
    Untuk melakukan NAT, `iptables` perlu diinstall dan dikonfigurasi pada Eru.
    -   Percobaan awal gagal karena `iptables` belum terinstal.
        ![insert-image-7](images/soal1-5_7.png)
    -   Instalasi `iptables` kemudian dilakukan.
        ![insert-image-8](images/soal1-5_8.png)
    -   Aturan NAT `MASQUERADE` berhasil ditambahkan. Pada tahap ini, alamat DNS server (`192.168.122.1`) juga dicatat dari file `/etc/resolv.conf` Eru.
        ![insert-image-9](images/soal1-5_9.png)

-   **Konfigurasi DNS dan Pengujian Akhir pada Client**
    Alamat DNS server yang didapat dari Eru kemudian dikonfigurasikan pada salah satu *client* (contoh: Melkor). Setelah konfigurasi DNS, dilakukan tes `ping google.com` yang akhirnya berhasil. Ini membuktikan bahwa *client* sudah dapat terhubung ke internet melalui Router Eru.
    ![insert-image-10](images/soal1-5_10.png)

---

## 5. Soal 5: Membuat Konfigurasi Persisten
Tujuan dari soal ini adalah untuk memastikan semua konfigurasi jaringan yang telah diatur tidak hilang atau ter-reset setelah setiap *node* di-*restart*.

### Solusi dan Implementasi
Pengerjaan soal ini secara otomatis sudah tercapai pada saat mengerjakan soal 2 dan 3. Konfigurasi jaringan pada sistem operasi Debian menjadi permanen ketika ditulis ke dalam file `/etc/network/interfaces`.

Semua skrip yang telah dibuat, seperti **`soal_2.sh`** dan **`soal_3.sh`**, bertugas untuk menulis atau menambahkan konfigurasi ke file tersebut. Dengan demikian, setiap kali *node* dinyalakan, sistem akan membaca file ini dan menerapkan konfigurasi IP secara otomatis.

![insert-image-11](images/soal1-5_11.png)

Verifikasi dapat dilakukan dengan sederhana, yaitu me-*restart* salah satu *node* (`reboot`) dan memeriksa kembali konfigurasinya (`ip a`) setelah menyala. Konfigurasi akan tetap sama seperti yang telah diatur.
