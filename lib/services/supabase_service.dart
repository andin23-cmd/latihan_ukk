import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // ================= LOGIN =================
  Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {
    try {
      // 1️⃣ LOGIN AUTH
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = res.user;
      if (user == null) return null;

      // 2️⃣ AMBIL ROLE DARI TABEL USERS
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
} // angfay
