import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  // WAJIB di dalam class
  final SupabaseClient _client = Supabase.instance.client;

  // Login manual
  Future<Map<String, dynamic>?> login(
      String email, String password) async {
    final response = await _client
        .from('users')
        .select()
        .eq('email', email)
        .eq('password_hash', password)
        .maybeSingle();

    return response;
  }

  // Ambil data alat + kategori
  Future<List<Map<String, dynamic>>> getAlat() async {
    final response = await _client
        .from('alat')
        .select('id, nama_alat, stok, status, kategori(nama_kategori)');

    return List<Map<String, dynamic>>.from(response);
  }

  // Logout
  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
