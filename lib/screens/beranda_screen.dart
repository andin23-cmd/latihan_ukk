import 'package:flutter/material.dart';
import '../models/alat_model.dart';
import 'detail_alat_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ===== BODY =====
      body: Column(
        children: [
          // ===== HEADER =====
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
            decoration: const BoxDecoration(
              color: Color(0xFF1A2C22),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Color(0xFF1A2C22)),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Halo, Andin',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const Icon(Icons.notifications, color: Colors.white),
                  ],
                ),

                const SizedBox(height: 16),

                const Text(
                  'Mau sewa alat apa ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Center(
                  child: Container(
                    height: 45,
                    width: 220,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF283F31),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          'Cari Alat',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===== CONTENT =====
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Rekomendasi untuk kamu',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Lihat Semua',
                        style: TextStyle(color: Color(0xFF1A2C22)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    height: 220,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        alatCard(context, AlatModel(id: '1', namaAlat: 'Headphone', stok: 25, status: 'Komputer')),
                        alatCard(context, AlatModel(id: '2', namaAlat: 'Keyboard', stok: 18, status: 'Komputer')),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Hasil Pencarian',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 14),

                  alatCard(context, AlatModel(id: '3', namaAlat: 'Monitor', stok: 12, status: 'Komputer')),
                ],
              ),
            ),
          ),
        ],
      ),

      // ===== BOTTOM NAV =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF1A2C22),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Barang'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Pesan'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Pengaturan'),
        ],
      ),
    );
  }

  // ===== CARD ALAT (SUDAH BISA DI KLIK) =====
  Widget alatCard(BuildContext context, AlatModel alat) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailAlatScreen(alat: {'nama': alat.namaAlat, 'stok': alat.stok, 'status': alat.status}),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/headphone.png',
                    height: 100,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.amber,
                    child: Text(
                      '${alat.stok}',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              alat.namaAlat,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              alat.status,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
