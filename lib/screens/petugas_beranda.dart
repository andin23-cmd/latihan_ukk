// main_navigator_petugas.dart
// Bottom Navigation Petugas seperti contoh gambar

import 'package:flutter/material.dart';

class BerandaPetugasPage extends StatelessWidget {
  const BerandaPetugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ⚠️ TANPA Scaffold & AppBar
    // Supaya BottomNavigationBar dari MainNavigatorPetugas MUNCUL
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _summarySection(),
            const SizedBox(height: 24),
            _pengajuanSection(),
            const SizedBox(height: 24),
            _laporanSection(context),
          ],
        ),
      ),
    );
  }

  Widget _summarySection() {
    return Row(
      children: const [
        _SummaryCard(
          title: 'Peminjam',
          value: '120',
          icon: Icons.people,
          color: Colors.green,
        ),
        _SummaryCard(
          title: 'Pengembalian',
          value: '3',
          icon: Icons.assignment_return,
          color: Colors.red,
        ),
        _SummaryCard(
          title: 'Menunggu',
          value: '12',
          icon: Icons.hourglass_bottom,
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _pengajuanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Pengajuan Peminjaman',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _PengajuanCard(nama: 'Andin', alat: 'Headphone', sewa: 'Sewa 2'),
        _PengajuanCard(nama: 'Andin', alat: 'Headphone', sewa: 'Sewa 2'),
      ],
    );
  }

  Widget _laporanSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Laporan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: const Icon(Icons.print, color: Colors.green),
            title: const Text('Cetak Laporan Peminjaman'),
            subtitle: const Text('PDF / Print'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        )
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PengajuanCard extends StatelessWidget {
  final String nama;
  final String alat;
  final String sewa;

  const _PengajuanCard({
    required this.nama,
    required this.alat,
    required this.sewa,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.person)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nama,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(alat),
                  Text(sewa, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {},
              child: const Text('Setuju'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {},
              child: const Text('Tolak'),
            ),
          ],
        ),
      ),
    );
  }
}
