import 'package:flutter/material.dart';
import 'dart:ui'; // Wajib untuk efek kaca buram (BackdropFilter)
import 'tourism_place.dart';

class DetailScreen extends StatefulWidget {
  final TourismPlace place;

  const DetailScreen({super.key, required this.place});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _ticketController = TextEditingController();
  String _totalPrice = "0";
  bool isFavorite = false;

  @override
  void dispose() {
    _ticketController.dispose();
    super.dispose();
  }

  // Fungsi untuk menghitung total harga saat input berubah
  void _calculateTotal() {
    setState(() {
      int ticketCount = int.tryParse(_ticketController.text) ?? 0;
      _totalPrice = (ticketCount * widget.place.price).toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil tinggi layar perangkat
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- 1. GAMBAR BACKGROUND ---
          // Gambar ditempatkan paling belakang dan diam.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.45, // Mengambil 45% dari tinggi layar
            child: Image.network(
              widget.place.imageUrl,
              fit: BoxFit.cover,
              // Jaring pengaman jika gambar gagal dimuat
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                ),
              ),
            ),
          ),

          // --- 2. KONTEN DETAIL YANG BISA DIGULIR ---
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Spasi kosong transparan di atas.
                  // Ini berfungsi sebagai "jendela" agar gambar di belakang terlihat.
                  SizedBox(height: (screenHeight * 0.45) - 40),

                  // Panel Konten Utama (Berwarna Putih)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // Membuat sudut atas melengkung
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5), // Bayangan ke atas
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Garis Indikator di tengah atas (Gaya iOS)
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Judul & Lokasi
                        Text(
                          widget.place.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.blueAccent, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              widget.place.location,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Deskripsi
                        const Text(
                          "Tentang Destinasi",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.place.description,
                          style: const TextStyle(
                            color: Colors.black87,
                            height: 1.6, // Jarak antar baris agar mudah dibaca
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 30),

                        // Garis pembatas (Divider)
                        Container(height: 1, color: Colors.grey[200]),
                        const SizedBox(height: 24),

                        // --- AREA PEMESANAN TIKET ---
                        const Text(
                          "Pesan Tiket",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Input Jumlah Orang
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F2F7), // Abu-abu sistem iOS
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _ticketController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Jumlah Orang',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              prefixIcon: Icon(Icons.people, color: Colors.grey),
                            ),
                            // Memanggil fungsi hitung total saat pengguna mengetik
                            onChanged: (value) => _calculateTotal(),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Baris Harga & Tombol Pesan
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Total Harga",
                                  style: TextStyle(color: Colors.grey, fontSize: 13),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Rp $_totalPrice",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Menampilkan notifikasi singkat
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Pesanan Berhasil!')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                elevation: 0, // Datar agar terlihat modern
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                "Book Now",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        // Ruang ekstra di bawah agar tidak mentok saat keyboard muncul
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- 3. TOMBOL NAVIGASI MELAYANG (Frosted Glass) ---
          // Tombol ini diletakkan paling bawah di Stack agar selalu berada di paling atas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol Kembali
                    _buildFrostedButton(
                      icon: Icons.arrow_back_ios_new,
                      iconColor: Colors.white,
                      onTap: () => Navigator.pop(context),
                    ),
                    // Tombol Favorit
                    _buildFrostedButton(
                      icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                      iconColor: isFavorite ? Colors.redAccent : Colors.white,
                      onTap: () => setState(() => isFavorite = !isFavorite),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET BANTUAN: Tombol Efek Kaca Buram ---
  Widget _buildFrostedButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        // Menentukan intensitas efek blur (kaca buram)
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25), // Hitam transparan
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
        ),
      ),
    );
  }
}