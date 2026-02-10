import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProdukScreen extends StatefulWidget {
  final Map<String, dynamic> produk;

  const EditProdukScreen({super.key, required this.produk});

  @override
  State<EditProdukScreen> createState() => _EditProdukScreenState();
}

class _EditProdukScreenState extends State<EditProdukScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _kategoriController;
  late TextEditingController _stokController;
  late TextEditingController _pinjamController;
  File? _image;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.produk['nama']);
    _kategoriController = TextEditingController(text: widget.produk['kategori']);
    _stokController = TextEditingController(text: widget.produk['stok'].toString());
    _pinjamController = TextEditingController(text: widget.produk['jangka_pinjam'].toString());
  }

  @override
  void dispose() {
    _namaController.dispose();
    _kategoriController.dispose();
    _stokController.dispose();
    _pinjamController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  Future<void> _simpanProduk() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Map<String, dynamic> dataUpdate = {
      'nama': _namaController.text,
      'kategori': _kategoriController.text,
      'stok': int.tryParse(_stokController.text) ?? 0,
      'jangka_pinjam': int.tryParse(_pinjamController.text) ?? 0,
    };

    try {
      // 1. Proses Upload Gambar jika ada perubahan
      if (_image != null) {
        final fileBytes = await _image!.readAsBytes();
        // Tambahkan timestamp agar nama file unik dan menghindari cache lama
        final fileName = 'produk_${widget.produk['id']}_${DateTime.now().millisecondsSinceEpoch}.png';
        
        await Supabase.instance.client.storage
            .from('produk-images')
            .uploadBinary(
              fileName, 
              fileBytes, 
              fileOptions: const FileOptions(upsert: true)
            );

        final String imageUrl = Supabase.instance.client.storage
            .from('produk-images')
            .getPublicUrl(fileName);
            
        dataUpdate['image_url'] = imageUrl;
      }

      // 2. Update Database menggunakan try-catch
      await Supabase.instance.client
          .from('produk')
          .update(dataUpdate)
          .eq('id', widget.produk['id']);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produk berhasil diperbarui')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Produk'),
        backgroundColor: const Color(0xFF0F2F1F),
        elevation: 0,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator()) 
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(_image!, fit: BoxFit.cover),
                            )
                          : (widget.produk['image_url'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(widget.produk['image_url'], fit: BoxFit.cover),
                                )
                              : const Icon(Icons.add_a_photo, size: 50, color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _namaController,
                    decoration: _inputDecoration('Masukan Nama Produk'),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) => value!.isEmpty ? 'Nama produk tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _kategoriController,
                    decoration: _inputDecoration('Masukan Kategori Produk'),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) => value!.isEmpty ? 'Kategori tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _stokController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration('Stok Barang'),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) => value!.isEmpty ? 'Stok tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _pinjamController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration('Jangka Pinjam'),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) => value!.isEmpty ? 'Jangka pinjam tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Batal', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _simpanProduk,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF41523B),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Simpan', style: TextStyle(color: Colors.white)),
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

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFF41523B),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(color: Colors.white70),
    );
  }
}