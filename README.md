# UTS MOBILE PROGRAMMING 2
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

# 🍽️ Food Order App

Aplikasi pemesanan makanan dan minuman berbasis **Flutter** dengan state management menggunakan **BLoC/Cubit**. Aplikasi ini memungkinkan pengguna untuk melihat menu, menambahkan item ke keranjang, dan melakukan pemesanan dengan fitur diskon otomatis.

---


## ✨ Fitur Utama

### 1. Manajemen Menu
- Menampilkan daftar menu makanan, minuman, dan snack
- Filter berdasarkan kategori (Semua, Makanan, Minuman, Snack)
- Tampilan kartu menu yang informatif dengan emoji sebagai ikon

### 2. Sistem Diskon
- **Diskon per Item**: Setiap item dapat memiliki diskon tersendiri (0-100%)
- **Diskon Transaksi**: Otomatis mendapat diskon 10% jika total belanja > Rp100.000

### 3. Keranjang Belanja
- Tambah dan kurangi jumlah item
- Perhitungan total otomatis
- Badge notifikasi jumlah item di keranjang

### 4. Ringkasan Pesanan
- Tampilan detail item yang dipesan
- Breakdown harga (subtotal, diskon, total)
- Konfirmasi pesanan dengan dialog

---

## 🏗️ Struktur Proyek

```
lib/
├── blocs/
│   └── order_cubit.dart        # State management dengan Cubit
├── models/
│   └── menu_model.dart         # Model data untuk menu
├── pages/
│   ├── order_home_page.dart    # Halaman utama (daftar menu)
│   ├── order_summary_page.dart # Halaman ringkasan pesanan
│   └── category_stack_page.dart# Halaman kategori menu
├── widgets/
│   └── menu_card.dart          # Widget kartu menu reusable
└── main.dart                   # Entry point aplikasi
```

---

## 📁 Penjelasan File

### 1. `main.dart`
Entry point aplikasi yang menginisialisasi:
- **BlocProvider**: Menyediakan `OrderCubit` ke seluruh widget tree
- **MaterialApp**: Konfigurasi tema aplikasi dengan warna pink sebagai primary color
- **ThemeData**: Custom theme untuk AppBar, ElevatedButton, dan FloatingActionButton

```dart
BlocProvider(
  create: (context) => OrderCubit(),
  child: MaterialApp(...)
)
```

### 2. `models/menu_model.dart`
Model data untuk item menu dengan properti:

| Properti | Tipe | Deskripsi |
|----------|------|-----------|
| `id` | String | ID unik menu |
| `name` | String | Nama menu |
| `description` | String | Deskripsi menu |
| `price` | int | Harga asli (dalam Rupiah) |
| `category` | String | Kategori (Makanan/Minuman/Snack) |
| `imageUrl` | String | Emoji sebagai representasi gambar |
| `discount` | double | Persentase diskon (0.0 - 1.0) |
| `quantity` | int | Jumlah item di keranjang |

**Method penting:**
- `getDiscountedPrice()`: Menghitung harga setelah diskon item
- `copyWith()`: Membuat salinan objek dengan nilai yang diubah

### 3. `blocs/order_cubit.dart`
State management menggunakan Cubit pattern dari flutter_bloc.

#### OrderState
Menyimpan state aplikasi:
- `menuItems`: Daftar semua menu
- `cartItems`: Item dalam keranjang
- `selectedCategory`: Filter kategori aktif

**Getter penting:**
```dart
subtotalPrice    // Total harga sebelum diskon transaksi
transactionDiscount  // Nilai diskon 10% jika subtotal > 100000
totalPrice       // Harga final setelah semua diskon
totalItems       // Jumlah total item di keranjang
categories       // Daftar kategori unik
filteredMenu     // Menu yang sudah difilter
```

#### OrderCubit
Method untuk manipulasi state:

| Method | Fungsi |
|--------|--------|
| `addToOrder(item)` | Menambah item ke keranjang |
| `removeFromOrder(item)` | Mengurangi/menghapus item dari keranjang |
| `updateQuantity(item, qty)` | Update jumlah item langsung |
| `clearOrder()` | Mengosongkan keranjang |
| `setCategory(category)` | Mengubah filter kategori |
| `getItemQuantity(id)` | Mendapatkan jumlah item di keranjang |

### 4. `widgets/menu_card.dart`
Widget reusable untuk menampilkan kartu menu.

**Props:**
- `menu`: Data menu (MenuModel)
- `quantity`: Jumlah item di keranjang
- `onAdd`: Callback saat tombol tambah ditekan
- `onRemove`: Callback saat tombol kurang ditekan

**Fitur tampilan:**
- Gradient background (putih ke pink)
- Shadow effect pada container
- Badge diskon jika item memiliki diskon
- Harga asli dicoret jika ada diskon

### 5. `pages/order_home_page.dart`
Halaman utama aplikasi dengan komponen:

1. **AppBar**: Judul dan tombol navigasi ke kategori
2. **Header Banner**: Pesan selamat datang dengan gradient
3. **Category Filter**: Horizontal scrollable chips untuk filter
4. **Menu List**: Daftar menu menggunakan ListView.builder
5. **Bottom Navigation Bar**: 
   - Ikon keranjang dengan badge jumlah item
   - Total harga
   - Tombol "Lihat Pesanan"

### 6. `pages/order_summary_page.dart`
Halaman ringkasan pesanan dengan:

1. **Banner Diskon**: Muncul jika mendapat diskon transaksi 10%
2. **Daftar Item**: Card untuk setiap item dengan detail harga
3. **Summary Section**:
   - Subtotal
   - Diskon transaksi (jika ada)
   - Total pembayaran
4. **Tombol Konfirmasi**: Membuka dialog konfirmasi pesanan

### 7. `pages/category_stack_page.dart`
Halaman kategori dengan tampilan ExpansionTile:

- Setiap kategori memiliki ikon dan warna berbeda
- Background gradient dan decorative emoji
- Expansion untuk melihat item dalam kategori
- Tap item untuk filter dan kembali ke home

---

## 💡 Cara Penggunaan

1. **Pilih Menu**: Browse menu di halaman utama
2. **Filter Kategori**: Tap chip kategori untuk memfilter
3. **Tambah ke Keranjang**: Tap tombol (+) pada menu
4. **Lihat Pesanan**: Tap tombol "Lihat Pesanan" di bottom bar
5. **Konfirmasi**: Review pesanan dan tap "Konfirmasi Pesanan"

---


<p align="center">
  Made with ❤️ using Flutter
</p>
