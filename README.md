# APLIKASI PEMESANAN MAKANAN
## UTS Mobile Programming 2
Nama   : Ajiza Firdaus

NPM    : 23552011059

Kelas  : TIF RP 23 CNS B

## TEORI & JAWABAN SOAL
🧩 1. Pengelolaan Transaksi dan Diskon Dinamis dengan Cubit

State management menggunakan Cubit membantu mengelola transaksi yang memiliki logika diskon dinamis dengan cara memisahkan logika bisnis dari tampilan (UI). Cubit memungkinkan setiap perubahan transaksi—seperti penambahan item, perubahan kuantitas, atau penerapan promo—diproses secara terpusat dalam satu state.
Dengan ini, Cubit dapat:
- Menghitung ulang subtotal, diskon, dan total pembayaran secara otomatis.
- Menerapkan berbagai aturan diskon dinamis (berdasarkan total belanja, jumlah item, membership, waktu promo, dll.).
- Mengirim state terbaru ke UI sehingga tampilan selalu konsisten dan ter-update.
- Mempermudah maintenance, scaling, dan penambahan aturan diskon baru tanpa mengubah UI.
Hasilnya, proses transaksi menjadi lebih stabil, mudah dipahami, dan lebih aman dari error karena UI tidak lagi menangani logika perhitungan rumit.

🛒 2. Perbedaan Diskon Per Item vs Diskon Total Transaksi
a. Diskon Per Item
Diskon yang diterapkan langsung pada barang tertentu, biasanya berdasarkan:
- Produk promo tertentu
- Promo beli banyak
- Potongan harga per kategori barang

Contoh di aplikasi kasir:
-Item “Minyak Goreng 1L” diskon 10%
- “Beli 3 Indomie, diskon 2.000 per item”
Hasilnya: setiap item memiliki harga akhir yang berbeda sesuai diskon masing-masing.

b. Diskon Total Transaksi
Diskon yang diterapkan setelah seluruh item dihitung, biasanya berdasarkan:
- Total belanja
- Membership
- Kode voucher
- Event promo (misalnya: belanja minimal 100 ribu, diskon 10%)

Contoh di aplikasi kasir:
- Total belanja Rp150.000 → diskon 10%
- Member Premium → diskon tambahan 5% dari total
Diskon ini bukan untuk item tertentu, tetapi mengurangi total akhir pembayaran.

🎨 3. Manfaat Widget Stack pada Tampilan Kategori Menu

Widget Stack memungkinkan penempatan widget secara bertumpuk (overlapping), sehingga sangat berguna untuk membuat tampilan kategori menu yang lebih modern dan informatif.
Manfaat penggunaan Stack pada menu kategori:
- Menampilkan elemen overlay, seperti badge, label promo, atau ikon favorit pada gambar kategori.
- Membuat kartu kategori lebih menarik, misalnya gambar sebagai background dengan teks di atasnya.
- Memudahkan penempatan elemen dekoratif, seperti gradient, shadow, dan highlight.
- Fleksibilitas desain tinggi, karena elemen bisa ditempatkan secara bebas menggunakan Positioned.

Contoh penerapan:
Menampilkan kategori “Minuman” berupa gambar dengan teks di bagian bawah dan badge promo di pojok kanan atas.

## PENJELASAN PROJEK APLIKASI
