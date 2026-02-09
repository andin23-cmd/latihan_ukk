import 'package:flutter/material.dart';

class BerandaAdminScreen extends StatelessWidget {
  const BerandaAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      // ===== APPBAR KOSONG =====
      appBar: AppBar(
        backgroundColor:Color(0xFF1F3D2B),
        elevation: 0,
      ),

      body: ListView(
        children: [

          // ===== HEADER PROFIL + NOTIF =====
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 34),
            decoration: const BoxDecoration(
              color: Color(0xFF1F3D2B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [

                // FOTO PROFIL
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage("assets/profile.png"),
                ),

                const SizedBox(width: 12),

                // TEXT
                 // TEXT
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: const [

    Text(
      "Selamat Datang, Admin 👋",
      style: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),

    SizedBox(height: 4),

    Text(
      "Dashboard Sistem Peminjaman Alat",
      style: TextStyle(
        color: Color.fromARGB(137, 255, 255, 255),
      ),
    ),

  ],
),

                // ICON NOTIF
    const SizedBox(width: 50),

    // ICON NOTIFIKASI
    IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.notifications_none,
        color: Colors.white,
      ),
    ),
              ],
            ),
          ),

          // ===== ISI DASHBOARD =====
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // SAPAAN
                
                const SizedBox(height: 20),

                // SEARCH
                SizedBox(
                  height: 48,
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Cari data...",
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: Colors.white,
                      filled: true,
                      fillColor: const Color(0xFF1F3D2B),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ===== STATISTIK =====
                Row(
                  children: [
                    Expanded(
                      child: _cardStatistik(
                        title: "Total Alat",
                        value: "120",
                        icon: Icons.inventory_2_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _cardStatistik(
                        title: "Total User",
                        value: "45",
                        icon: Icons.people_outline,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _cardStatistik(
                        title: "Dipinjam",
                        value: "35",
                        icon: Icons.handshake_outlined,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _cardStatistik(
                        title: "Pengembalian",
                        value: "12",
                        icon: Icons.keyboard_return,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _aktivitasItem(
                  "Andin memnyetujui peminjaman Laptop",
                  "2 menit lalu",
                ),
                _aktivitasItem(
                  "Budi menolak Proyektor",
                  "10 menit lalu",
                ),
                _aktivitasItem(
                  "Dian telah logout",
                  "1 jam lalu",
                ),

                const SizedBox(height: 28),

               
                const Text(
                  "Aktivitas Peminjam",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                _aktivitasItem(
                  "Andin meminjam Laptop",
                  "2 menit lalu",
                ),
                _aktivitasItem(
                  "Budi mengembalikan Proyektor",
                  "10 menit lalu",
                ),
                _aktivitasItem(
                  "Joko telah logout",
                  "1 jam lalu",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 
  Widget _cardStatistik({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F3D2B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70)),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===== AKTIVITAS ITEM =====
  Widget _aktivitasItem(String title, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1F3D2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.history, color: Colors.white70),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white)),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
