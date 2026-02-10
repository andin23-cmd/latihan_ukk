import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class TambahProdukAdminScreen extends StatefulWidget {
  const TambahProdukAdminScreen({super.key});

  @override
  State<TambahProdukAdminScreen> createState() =>
      _TambahProdukAdminScreenState();
}

class _TambahProdukAdminScreenState
    extends State<TambahProdukAdminScreen> {

  // ================= IMAGE =================
  File? _image;
  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();

  // ================= CONTROLLER =================
  final namaC = TextEditingController();
  final stokC = TextEditingController();
  final jangkaC = TextEditingController();

  // ================= KATEGORI =================
  List<Map<String, dynamic>> listKategori = [];
  String? selectedKategoriId;

  // ===== INIT LOAD KATEGORI =====
  @override
  void initState() {
    super.initState();
    loadKategori();
  }

  Future<void> loadKategori() async {
    final supabase = Supabase.instance.client;

    final data = await supabase
        .from('kategori')
        .select('id, nama_kategori');

    setState(() {
      listKategori =
          List<Map<String, dynamic>>.from(data);
    });
  }

  // ===== PILIH GAMBAR =====
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        _imageBytes = await pickedFile.readAsBytes();
      } else {
        _image = File(pickedFile.path);
      }
      setState(() {});
    }
  }

  // ================= UPLOAD GAMBAR =================
  Future<String?> uploadGambar() async {
    final supabase = Supabase.instance.client;

    try {
      if (_image == null && _imageBytes == null) return null;

      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}.png';

      if (kIsWeb) {
        await supabase.storage
            .from('produk')
            .uploadBinary(fileName, _imageBytes!);
      } else {
        await supabase.storage
            .from('produk')
            .upload(fileName, _image!);
      }

      final url = supabase.storage
          .from('produk')
          .getPublicUrl(fileName);

      return url;
    } catch (e) {
      print('ERROR UPLOAD: $e');
      return null;
    }
  }

  // ================= SIMPAN PRODUK =================
  Future<void> _simpanProduk() async {
    final supabase = Supabase.instance.client;

    try {
      if (selectedKategoriId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Pilih kategori dulu')),
        );
        return;
      }

      final imageUrl = await uploadGambar();

      await supabase.from('alat').insert({
        'nama_alat': namaC.text,
        'kategori_id': selectedKategoriId, // UUID otomatis
        'stok': int.parse(stokC.text),
        'jangka_waktu': int.parse(jangkaC.text),
        'status': 'tersedia',
        'gambar_url': imageUrl,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produk berhasil disimpan'),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromARGB(255, 190, 190, 190),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // ===== IMAGE =====
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 190,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: (_image != null || _imageBytes != null)
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10),
                          child: kIsWeb
                              ? Image.memory(
                                  _imageBytes!,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                        )
                      : Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.image_rounded,
                                size: 50,
                                color: Colors.white70),
                            SizedBox(height: 8),
                            Text(
                              "Tambah Gambar",
                              style: TextStyle(
                                  color: Colors.white70),
                            )
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 40),

              _inputField("Masukan Nama Produk",
                  controller: namaC),
              const SizedBox(height: 30),

              // ===== DROPDOWN KATEGORI =====
              DropdownButtonFormField<String>(
                value: selectedKategoriId,
                hint: const Text("Pilih Kategori"),
                items: listKategori.map((kategori) {
                  return DropdownMenuItem<String>(
                    value: kategori['id'],
                    child:
                        Text(kategori['nama_kategori']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedKategoriId = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF1F3D2B),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                dropdownColor:
                    const Color(0xFF1F3D2B),
                style:
                    const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 30),

              _inputField("Stok Barang",
                  controller: stokC),
              const SizedBox(height: 30),

              _inputField("Jangka Pinjam",
                  controller: jangkaC),
              const SizedBox(height: 50),

              // ===== BUTTON =====
              Row(
                children: [

                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text("Batal"),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: GestureDetector(
                      onTap: _simpanProduk,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F3D2B),
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Simpan",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= INPUT =================
  Widget _inputField(
    String hint, {
    TextEditingController? controller,
  }) {
    return SizedBox(
      height: 45,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color(0xFF1F3D2B),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
