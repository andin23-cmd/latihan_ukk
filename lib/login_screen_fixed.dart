import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // ← WAJIB untuk AuthException
import 'services/supabase_service.dart';

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
  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ================= LOGIN FUNCTION =================
  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = null; // reset error lama
    });

    try {
      final supabase = service.supabase;

      final authRes = await supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = authRes.user;
      if (user == null) {
        throw const AuthException('Invalid login credentials');
      }

      // ================= AMBIL PROFIL =================
      final profil = await supabase
          .from('profil')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (!mounted) return;

      if (profil == null) {
        setState(() {
          isLoading = false;
          errorMessage = 'User tidak ditemukan di tabel profil';
        });
        return;
      }

      final String role = profil['role'] ?? '';

      setState(() => isLoading = false);

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
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      }
    }

    // ================= ERROR AUTH =================
    on AuthException catch (e) {
      setState(() {
        isLoading = false;

        if (e.message.contains('Invalid login credentials')) {
          errorMessage = 'Email atau kata sandi salah';
        } else if (e.message.contains('Email not confirmed')) {
          errorMessage = 'Email belum dikonfirmasi';
        } else {
          errorMessage = e.message;
        }
      });
    }

    // ================= ERROR UMUM =================
    catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Terjadi kesalahan sistem';
      });
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
                'E-Cashier',
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

              // ================= EMAIL =================
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

              // ================= PASSWORD =================
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

              const SizedBox(height: 14),

              // ================= ERROR MESSAGE =================
              if (errorMessage != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              const SizedBox(height: 20),

              // ================= BUTTON =================
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
