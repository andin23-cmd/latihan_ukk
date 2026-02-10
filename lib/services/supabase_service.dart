import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // ================= LOGIN =================
  Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = res.user;
      if (user == null) return null;

      final data = await supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .single();

      return data;
    } catch (e) {
      print('ERROR LOGIN: $e');
      return null;
    }
  }

  // ================= GET ALAT + KATEGORI =================
  Future<List<Map<String, dynamic>>> getAlat({
    String? kategoriId,
    String? search,
  }) async {
    try {
      var query = supabase.from('alat').select('''
        *,
        kategori:kategori_id (
          id,
          nama_kategori
        )
      ''');

      // ===== FILTER KATEGORI =====
      if (kategoriId != null && kategoriId.isNotEmpty) {
        query = query.eq('kategori_id', kategoriId);
      }

      // ===== SEARCH NAMA =====
      if (search != null && search.isNotEmpty) {
        query = query.ilike('nama_alat', '%$search%');
      }

      final data = await query;

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('ERROR GET ALAT: $e');
      return [];
    }
  }

  // ================= GET KATEGORI =================
  Future<List<Map<String, dynamic>>> getKategori() async {
    try {
      final data =
          await supabase.from('kategori').select();

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('ERROR GET KATEGORI: $e');
      return [];
    }
  }
}
