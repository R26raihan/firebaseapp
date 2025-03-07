# Sistem Aplikasi dengan Flutter dan FastAPI

Sistem ini merupakan sebuah aplikasi yang menggabungkan kekuatan **Flutter** untuk pengembangan antarmuka pengguna (UI) yang modern dan **FastAPI** untuk membangun backend yang cepat dan efisien. Berikut adalah penjelasan singkat tentang teknologi yang digunakan.

## Teknologi yang Digunakan

### 1. Flutter (Frontend)
- **Flutter** adalah framework open-source dari Google yang digunakan untuk membangun aplikasi mobile, web, dan desktop dari satu basis kode (codebase).
- Dalam sistem ini, Flutter digunakan untuk:
  - Membuat antarmuka pengguna yang responsif dan menarik.
  - Menghubungkan aplikasi dengan backend melalui API.
  - Menampilkan data dari backend secara real-time.
  - Mengelola state aplikasi dengan efisien menggunakan provider atau state management lainnya.

### 2. FastAPI (Backend)
- **FastAPI** adalah framework modern untuk membangun API dengan Python yang cepat dan mudah digunakan. FastAPI dikenal karena kecepatannya yang tinggi dan dukungan bawaan untuk validasi data, dokumentasi otomatis (Swagger UI), dan dukungan async/await.
- Dalam sistem ini, FastAPI digunakan untuk:
  - Membangun RESTful API yang menghubungkan aplikasi Flutter dengan database.
  - Mengelola logika bisnis dan autentikasi pengguna.
  - Menyediakan endpoint untuk operasi CRUD (Create, Read, Update, Delete).
  - Mengintegrasikan dengan Firebase atau database lainnya untuk menyimpan dan mengambil data.

### 3. Integrasi Flutter dan FastAPI
- Aplikasi Flutter berkomunikasi dengan backend FastAPI melalui HTTP requests (GET, POST, PUT, DELETE).
- Data dikirim dalam format JSON antara Flutter dan FastAPI.
- FastAPI memvalidasi data yang diterima dari Flutter sebelum memprosesnya lebih lanjut.
- Flutter menampilkan respons dari FastAPI kepada pengguna dalam bentuk yang mudah dipahami.

## Fitur Sistem
- **Autentikasi Pengguna**: Sistem ini mendukung login dan registrasi pengguna dengan validasi data yang aman.
- **Manajemen Data**: Pengguna dapat membuat, membaca, memperbarui, dan menghapus data melalui antarmuka Flutter.
- **Responsif dan Cepat**: Berkat Flutter dan FastAPI, sistem ini menawarkan pengalaman pengguna yang lancar dan responsif.
- **Keamanan**: FastAPI dilengkapi dengan validasi data bawaan dan dukungan untuk autentikasi OAuth2, sehingga sistem ini aman dari serangan umum seperti SQL injection atau data injection.


# Demo Video
https://youtu.be/OAInezOqaPw
