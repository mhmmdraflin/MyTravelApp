import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'tourism_place.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan warna latar belakang yang sudah kita set di main.dart
      backgroundColor: const Color(0xFFF2F2F7),
      body: CustomScrollView(
        slivers: [
          // --- 1. SLIVER APP BAR (Efek Large Title Khas iOS) ---
          const SliverAppBar(
            expandedHeight: 140.0, // Tinggi saat judul sedang besar
            floating: false,
            pinned: true, // Judul tetap menempel di atas saat di-scroll
            backgroundColor: Color(0xFFF2F2F7),
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                'Explore Indonesia',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800, // Tebal khas Apple
                  letterSpacing: -0.5,
                ),
              ),
              // Subtitle yang akan hilang saat di-scroll ke atas
              background: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 60),
                  child: Text(
                    'Temukan keindahan alam nusantara',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // --- 2. KOMPONEN SEARCH & REKOMENDASI ---
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar Minimalis
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.06), // Warna abu transparan
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.black54, size: 20),
                        SizedBox(width: 10),
                        Text(
                          'Cari destinasi...',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Judul Bagian Rekomendasi
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Rekomendasi',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // List Horizontal Rekomendasi
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: tourismPlaceList.length,
                    itemBuilder: (context, index) {
                      final place = tourismPlaceList[index];
                      return _buildHorizontalCard(context, place);
                    },
                  ),
                ),
                const SizedBox(height: 30),

                // Judul Bagian List Wisata
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'List Wisata',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // --- 3. VERTICAL LIST (Daftar Wisata Utama) ---
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final place = tourismPlaceList[index];
                  return _buildVerticalCard(context, place);
                },
                childCount: tourismPlaceList.length,
              ),
            ),
          ),

          // Memberikan padding di paling bawah agar tidak mepet home indicator
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  // WIDGET BANTUAN: Desain Kartu Rekomendasi (Horizontal)
  Widget _buildHorizontalCard(BuildContext context, TourismPlace place) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(place: place);
        }));
      },
      child: Container(
        width: 190,
        margin: const EdgeInsets.only(right: 18, bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22), // Sudut sangat melengkung (Apple style)
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04), // Bayangan sangat halus
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar dengan sudut melengkung hanya di atas
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
              child: Image.network(
                place.imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                place.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET BANTUAN: Desain Kartu Daftar Wisata (Vertical)
  Widget _buildVerticalCard(BuildContext context, TourismPlace place) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(place: place);
        }));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Gambar di samping kiri
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(22)),
              child: Image.network(
                place.imageUrl,
                width: 115,
                height: 115,
                fit: BoxFit.cover,
              ),
            ),
            // Teks Info di samping kanan
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          place.location,
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Rp ${place.price}",
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}