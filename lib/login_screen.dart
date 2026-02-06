import 'package:flutter/material.dart';
import 'services/supabase_service.dart';
import 'package:flutter_application_1/screens/admin_beranda.dart';
import 'package:flutter_application_1/screens/petugas_beranda.dart';
import 'package:flutter_application_1/screens/peminjam_screen.dart';

void login() async {
  try {
    setState(() => isLoading = true);

    final supabase = service.client;

    // ================= LOGIN AUTH =================
    final authRes = await supabase.auth.signInWithPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    final user = authRes.user;

    if (user == null) {
      throw Exception('Auth gagal');
    }

    // ================= AMBIL PROFIL =================
    final profil = await supabase
        .from('profil')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    setState(() => isLoading = false);

    if (!mounted) return;

    // ================= CEK PROFIL =================
    if (profil == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Login gagal. User tidak ditemukan di tabel profil.',
          ),
        ),
      );
      return;
    }

    String role = profil['role'];

    // ================= NAVIGASI ROLE =================
    if (role == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const AdminBeranda(),
        ),
      );
    } 
    else if (role == 'petugas') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const PetugasBeranda(),
        ),
      );
    } 
    else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        ),
      );
    }

  } catch (e) {
    setState(() => isLoading = false);

    print('ERROR LOGIN UI: $e');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Terjadi error: $e'),
      ),
    );
  }
}

  // ================= UI (TIDAK DIUBAH) =================
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
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
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
