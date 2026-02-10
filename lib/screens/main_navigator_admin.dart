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
  // index halaman yang aktif
  int _selectedIndex = 0;

  // list halaman, urutannya harus sama dengan BottomNavigationBarItem
  final List<Widget> _pages = [
    const BerandaAdminScreen(),                   // 0
    const AdminAlatScreen(),                      // 1
    const Center(child: Text("Halaman Aktivitas")), // 2
          // 3, bisa dihapus kalau tidak perlu
    const PengaturanScreen(),                     // 4
  ];

  // list BottomNavigationBarItem
  final List<BottomNavigationBarItem> _navItems = const [
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
      icon: Icon(Icons.settings),
      label: "Pengaturan",
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // pastikan index tidak lebih besar dari jumlah halaman
    final int safeIndex = _selectedIndex.clamp(0, _pages.length - 1);

    return Scaffold(
      body: _pages[safeIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: safeIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: const Color(0xFF1F3D2B),
        unselectedItemColor: Colors.grey,
        items: _navItems,
      ),
    );
  }
}
