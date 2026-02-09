import 'package:flutter/material.dart';
import 'admin_beranda.dart';
import 'alat_admin.dart';
import 'pengaturan_admin.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({super.key});

  @override
  State<MainAdminScreen> createState() => _MainAdminScreenState();
}

class _MainAdminScreenState extends State<MainAdminScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BerandaAdminScreen(),
    const AdminAlatScreen(),
    const Center(child: Text("Halaman Aktivitas")),
    const Center(child: Text("Halaman User")),
    const PengaturanScreen(), // pastikan class ini ada
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: const Color(0xFF1F3D2B),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: "Alat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: "Aktivitas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
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
}
