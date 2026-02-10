import 'package:flutter/material.dart';
import 'petugas_beranda.dart';

class MainNavigatorPetugas extends StatefulWidget {
  const MainNavigatorPetugas({super.key});

  @override
  State<MainNavigatorPetugas> createState() => _MainNavigatorPetugasState();
}

class _MainNavigatorPetugasState extends State<MainNavigatorPetugas> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    BerandaPetugasPage(),
    Center(child: Text('Riwayat')),
    Center(child: Text('Pesan')),
    Center(child: Text('Pengaturan')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petugas'),
        backgroundColor: const Color(0xFF1F3D2B),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Pesan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
