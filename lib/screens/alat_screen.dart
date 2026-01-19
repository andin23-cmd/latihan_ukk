import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class AlatScreen extends StatelessWidget {
  const AlatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = SupabaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Alat'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: service.getAlat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Data alat kosong'));
          }

          final data = snapshot.data as List;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final alat = data[index];

              // 🔒 NULL SAFETY
              final kategori =
                  alat['kategori']?['nama_kategori'] ?? 'Tidak ada';
              final status = alat['status'] ?? 'tidak diketahui';

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(Icons.build, color: Colors.blue),
                  ),
                  title: Text(
                    alat['nama_alat'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Kategori: $kategori'),
                      Text('Stok: ${alat['stok']}'),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(
                      status,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor:
                        status == 'tersedia' ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
