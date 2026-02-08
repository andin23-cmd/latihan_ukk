import 'package:flutter/material.dart';

class AdminAlatScreen extends StatelessWidget {
  const AdminAlatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [

            // ===== SEARCH + FILTER =====
            Row(
              children: [
                SizedBox(
  width: 260, // PANJANG
  height: 48, // TINGGI
  child: TextField(
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: "Cari alat...",
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


                const SizedBox(width: 10),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F3D2B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.filter_list,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
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
            ),
          ],
        ),
      ),

      // ================= FAB =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1F3D2B),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Headphone",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Kategori : Komputer"),
                    Text("Stok : 25"),
                  ],
                ),
              ),

              Row(
                children: [
                  Icon(Icons.edit, color: const Color(0xFF1F3D2B)),
                ],
              )
            ],
          ),

          const Divider(height: 20),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Jangka Pinjam : 3 Hari"),
              Chip(
                label: Text("Tersedia"),
                backgroundColor: const Color(0xFF1F3D2B),
                labelStyle: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
