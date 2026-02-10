import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main_navigator_petugas.dart';
import 'services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter_application_1/screens/main_navigator_admin.dart';
import 'package:flutter_application_1/screens/petugas_beranda.dart';
import 'package:flutter_application_1/screens/peminjam_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SupabaseService service = SupabaseService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    try {
      setState(() => isLoading = true);

      final supabase = service.supabase;

      // ================= LOGIN AUTH =================
      final authRes = await supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = authRes.user;

      if (user == null) {
        throw Exception('Login gagal');
      }

      // ================= AMBIL DATA USERS =================
      final data = await supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      setState(() => isLoading = false);

      if (!mounted) return;

      if (data == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'User tidak ditemukan di tabel users',
            ),
          ),
        );
        return;
      }

      final String role = data['role'] ?? '';

      // ================= REDIRECT ROLE =================
      if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainAdminScreen()),
        );
      } else if (role == 'petugas') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BerandaPetugasPage()),
        );
      } else if (role == 'petugas') {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const MainNavigatorPetugas()),
  );
} else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Role tidak dikenali'),
          ),
        );
      }
    } on AuthException catch (e) {
  setState(() => isLoading = false);

  if (!mounted) return;

  String message = '';

  // ================= CEK JENIS ERROR =================
  if (e.message.contains('Invalid login credentials')) {
    message = 'Email atau kata sandi salah';
  } else if (e.message.contains('Email not confirmed')) {
    message = 'Email belum dikonfirmasi';
  } else {
    message = e.message; // default dari supabase
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );

} catch (e) {
  setState(() => isLoading = false);

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Terjadi kesalahan sistem')),
  );
}

  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: 393,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1F3D2B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),

              const Text(
                'Pinjam Alat',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Selamat datang',
                style: TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Kata sandi',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isLoading ? null : login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F5D43),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
