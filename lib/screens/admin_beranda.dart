import 'package:flutter/material.dart';

class AdminAlatScreen extends StatelessWidget {
  const AdminAlatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ================= APPBAR =================
      appBar: AppBar(
        title: const Text("Kelola Alat"),
        backgroundColor: const Color(0xFF1F3D2B),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Aksi tambah alat
            },
          )
        ],
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ===== SEARCH + FILTER =====
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari alat...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F3D2B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.filter_list, color: Colors.white),
                )
              ],
            ),

            const SizedBox(height: 20),

            // ===== LIST ALAT =====
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _cardAlat();
                },
              ),
            )
          ],
        ),
      ),

      // ================= FAB =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1F3D2B),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF1F3D2B),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: "Alat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "User",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Pengaturan",
          ),
        ],
      ),
    );
  }

  // ================= CARD ALAT =================
  Widget _cardAlat() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black12,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [

          // ===== ATAS =====
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage("assets/headphone.png"),
              ),
              const SizedBox(width: 12),

              // INFO ALAT
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Headphone",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("Kategori : Komputer"),
                    Text("Stok : 25"),
                  ],
                ),
              ),

              // AKSI
              Row(
                children: [
                  Icon(Icons.edit, color: Colors.green[700]),
                  const SizedBox(width: 10),
                  const Icon(Icons.delete, color: Colors.red),
                ],
              )
            ],
          ),

          const Divider(height: 20),

          // ===== BAWAH =====
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Jangka Pinjam : 3 Hari"),
              Chip(
                label: Text("Tersedia"),
                backgroundColor: Colors.green,
                labelStyle: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
