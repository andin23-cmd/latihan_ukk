
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_1/login_screen.dart';

class PengaturanScreen extends StatelessWidget {
  const PengaturanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2F1F),
        elevation: 0,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F2F1F),
              Color(0xFF1E4D33),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          children: [
            const SizedBox(height: 30),

            // ===== FOTO =====
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.amber,
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage(
                      "assets/profile.png",
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 15),

            const Text(
              "Admin",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "admin@gmail.com",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            _menuItem(icon: Icons.person, title: "Ubah Profil"),
            _menuItem(icon: Icons.lock, title: "Ganti Akun"),
            _menuItem(icon: Icons.calendar_today, title: "Riwayat"),

            const Spacer(),

            // ===== BUTTON LOGOUT =====
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: GestureDetector(
                onTap: () async {

  // ===== DIALOG KONFIRMASI =====
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      title: const Text("Konfirmasi"),
      content: const Text("Anda yakin ingin keluar?"),

      actions: [

        // ===== TOMBOL TIDAK =====
        TextButton(
          onPressed: () {
            Navigator.pop(context); // tutup dialog
          },
          child: const Text("Tidak"),
        ),

        // ===== TOMBOL YA =====
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F2F1F),
            foregroundColor: Colors.white,
          ),
          onPressed: () async {

            // Logout Supabase
            await Supabase.instance.client.auth.signOut();

            // Pindah ke Login & hapus semua halaman
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          },
          child: const Text("Ya"),
        ),
      ],
    ),
  );

},


                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Keluar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== MENU ITEM =====
  static Widget _menuItem({
    required IconData icon,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
