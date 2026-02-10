import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/pinjam_screen.dart';

class DetailAlatScreen extends StatelessWidget {
  final Map<String, dynamic> alat;

  const DetailAlatScreen({super.key, required this.alat});

  @override
  Widget build(BuildContext context) {
    // ===== AMANKAN DATA =====
    final String namaAlat = alat['nama_alat'] ?? 'Nama tidak tersedia';
    final int stok = alat['stok'] ?? 0;
    final int jangkaWaktu = alat['jangka_waktu'] ?? 1;
    final String? gambarUrl = alat['gambar_url'];

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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: gambarUrl != null
                  ? Image.network(
                      gambarUrl,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      'assets/images/headphone.png',
                      height: 220,
                      fit: BoxFit.contain,
                    ),
            ),
          ),

          const SizedBox(height: 12),

          // ===== CARD DETAIL =====
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF1A2C22),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== JUDUL =====
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
                    'Stok tersedia: $stok',
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 16),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 12),

                  // ===== ATURAN =====
                  _aturan('Jangan dijual'),
                  _aturan('Jangan merusak barang'),
                  _aturan('Kembalikan tepat waktu'),

                  const Spacer(),

                  // ===== JANGKA PINJAM =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Jangka Pinjam',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '$jangkaWaktu Hari',
                        style: const TextStyle(
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
                        backgroundColor: const Color(0xFFFFC107),
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
                      onPressed: stok <= 0
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PesananScreen(
                                    alat: alat,
                                  ),
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

  // ===== WIDGET ATURAN =====
  Widget _aturan(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.grey,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
