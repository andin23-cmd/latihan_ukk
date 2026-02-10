import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/tambah_produk_admin.dart';
import 'package:flutter_application_1/services/supabase_service.dart';


class AdminAlatScreen extends StatefulWidget {
  const AdminAlatScreen({super.key});

  @override
  State<AdminAlatScreen> createState() => _AdminAlatScreenState();
}

class _AdminAlatScreenState extends State<AdminAlatScreen> {
  final service = SupabaseService();

  late Future<List<Map<String, dynamic>>> futureAlat;

  String? selectedKategoriId;
  String searchText = "";

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // ================= LOAD DATA =================
  void loadData() {
    futureAlat = service.getAlat(
      kategoriId: selectedKategoriId,
      search: searchText,
    );
  }

  void refreshData() {
    setState(() {
      loadData();
    });
  }

  // ================= DIALOG FILTER =================
  Future<void> showFilterDialog() async {
    final kategori = await service.getKategori();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Filter Kategori"),
          content: SizedBox(
            width: 300,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: kategori.length,
              itemBuilder: (context, index) {
                final data = kategori[index];
                return ListTile(
                  title: Text(data['nama_kategori']),
                  onTap: () {
                    selectedKategoriId = data['id'];
                    Navigator.pop(context);
                    refreshData();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [

            // ===== SEARCH + FILTER =====
            Row(
              children: [
                SizedBox(
                  width: 260,
                  height: 48,
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      searchText = value;
                      refreshData();
                    },
                    decoration: InputDecoration(
                      hintText: "Cari alat...",
                      hintStyle:
                          const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: Colors.white,
                      filled: true,
                      fillColor: const Color(0xFF1F3D2B),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                GestureDetector(
                  onTap: showFilterDialog,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F3D2B),
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ===== LIST =====
            Expanded(
              child:
                  FutureBuilder<List<Map<String, dynamic>>>(
                future: futureAlat,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child:
                          Text("Error : ${snapshot.error}"),
                    );
                  }

                  final alat = snapshot.data ?? [];

                  if (alat.isEmpty) {
                    return const Center(
                      child:
                          Text("Belum ada data alat"),
                    );
                  }

                  return ListView.builder(
                    itemCount: alat.length,
                    itemBuilder: (context, index) {
                      return _cardAlat(alat[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ================= FAB =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1F3D2B),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const TambahProdukAdminScreen(),
            ),
          );

          refreshData();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // ================= CARD =================
  Widget _cardAlat(Map<String, dynamic> data) {
    final kategoriNama =
        data['kategori']?['nama_kategori'] ?? '-';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black12,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundImage:
                    AssetImage("assets/headphone.png"),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['nama_alat'] ?? '-',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        "Kategori : $kategoriNama"),
                    Text(
                        "Stok : ${data['stok'] ?? 0}"),
                  ],
                ),
              ),

              const Icon(Icons.edit,
                  color: Color(0xFF1F3D2B))
            ],
          ),

          const Divider(height: 20),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Jangka Pinjam : ${data['jangka_waktu'] ?? 0} Hari"),
              Chip(
                label:
                    Text(data['status'] ?? '-'),
                backgroundColor:
                    const Color(0xFF1F3D2B),
                labelStyle: const TextStyle(
                    color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}