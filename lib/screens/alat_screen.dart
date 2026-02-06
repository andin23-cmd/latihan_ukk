import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // ================= GET ALAT =================
  Future<List<dynamic>> getAlat() async {
    try {
      final data = await supabase
          .from('alat')
          .select('''
            *,
            kategori (
              nama_kategori
            )
          ''');

      return data;
    } catch (e) {
      print('ERROR GET ALAT: $e');
      return [];
    }
  }
}
