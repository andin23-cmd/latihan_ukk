import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // ================= GET DATA ALAT =================
  Future<List<Map<String, dynamic>>> getAlat() async {
    try {
      final response = await supabase
          .from('alat')
          .select('''
            id,
            nama_alat,
            stok,
            kondisi,
            status,
            gambar_url,
            jangka_waktu,
            kategori (
              nama_kategori
            )
          ''')
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('ERROR GET ALAT: $e');
      return [];
    }
  }
}