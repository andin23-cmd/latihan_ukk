import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';

class TambahProdukAdminScreen extends StatefulWidget {
  const TambahProdukAdminScreen({super.key});

  @override
  State<TambahProdukAdminScreen> createState() =>
      _TambahProdukAdminScreenState();
}

class _TambahProdukAdminScreenState
    extends State<TambahProdukAdminScreen> {

 File? _image;          
Uint8List? _imageBytes; 
final ImagePicker _picker = ImagePicker();

  // ===== FUNGSI PILIH GAMBAR =====
  Future<void> _pickImage() async {
  final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    if (kIsWeb) {
      // WEB → simpan bytes
      _imageBytes = await pickedFile.readAsBytes();
    } else {
      // MOBILE / DESKTOP → simpan file
      _image = File(pickedFile.path);
    }

    setState(() {});
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      // ===== APPBAR =====
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // ===== BODY =====
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

              // ===== IMAGE UPLOAD =====
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 190,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // jika gambar ada → tampilkan
                 child: (_image != null || _imageBytes != null)
    ? ClipRRect(
        borderRadius: BorderRadius.circular(10),
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

                      // jika belum → tampilkan icon + teks
                      : Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.image_rounded,
                              size: 50,
                              color: Colors.white70,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Tambah Gambar",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            )
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 40),

              // ===== INPUT =====
              _inputField("Masukan Nama Produk"),
              const SizedBox(height: 30),

              _inputField("Masukan Kategori Produk"),
              const SizedBox(height: 30),

              _inputField("Stok Barang"),
              const SizedBox(height: 30),

              _inputField("Jangka Pinjam"),
              const SizedBox(height: 50),

              // ===== BUTTON =====
              Row(
                children: [

                  // BATAL
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Batal",
                          style: TextStyle(
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // SIMPAN
                  Expanded(
                child: GestureDetector(
                  onTap: _simpanProduk,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F3D2B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

                ],
                  ),
                ],
              )
          ),
        ),
      
    );
  }
  

  // ===== METHOD SIMPAN PRODUK =====
  void _simpanProduk() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produk berhasil disimpan')),
    );
  }

  // ===== WIDGET INPUT =====
  Widget _inputField(String hint) {
    return SizedBox(
      height: 45,
      child: TextField(
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
