import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/beranda_screen.dart';

class DetailAlatScreen extends StatelessWidget {
  final Map alat;

  const DetailAlatScreen({super.key, required this.alat});

  @override
  Widget build(BuildContext context) {
    // ✅ AMANKAN DATA
    final String namaAlat = alat['nama_alat'] ?? 'Nama tidak tersedia';
    final int stok = alat['stok'] ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,

      // ===== APPBAR =====
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // ===== BODY =====
      body: Column(
        children: [
          // ===== GAMBAR =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              'assets/images/headphone.png', // pastikan path benar
              height: 220,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 12),

          // ===== CARD DETAIL =====
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Color(0xFF1A2C22),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // JUDUL
                  Text(
                    namaAlat,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Stok $stok',
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 16),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 12),

                  // ATURAN
                  Row(
                    children: const [
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.grey, size: 18),
                      SizedBox(width: 8),
                      Text('Jangan di jual',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.grey, size: 18),
                      SizedBox(width: 8),
                      Text('Jangan merusak barang',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),

                  const Spacer(),

                  // ===== FOOTER =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Jangka Pinjam',
                          style: TextStyle(color: Colors.grey)),
                      Text(
                        '3 Hari',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ===== BUTTON =====
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFC107),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Pinjam Sekarang',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const DashboardScreen(),
    ),
  );
},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
