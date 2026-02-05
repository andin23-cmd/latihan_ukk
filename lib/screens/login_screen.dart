import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import 'admin_beranda.dart'; //error here
import 'petugas_beranda.dart'; //error here
import 'peminjam_screen.dart'; //error here

class LoginScreen extends StatefulWidget {
const LoginScreen({super.key});

@override
State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final emailController = TextEditingController();
final passwordController = TextEditingController();
final service = SupabaseService();

bool _obscurePassword = true;

void login() async {
final result = await service.login(
emailController.text,
passwordController.text,
);

if (!mounted) return;

if (result != null) {
  String role = result['role'];

  // NAVIGASI BERDASARKAN ROLE
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
else if (role == 'peminjam') {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => const DashboardScreen(),
    ),
  );
}
} else {
  // Tampilkan pesan error
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Login gagal. Periksa email dan kata sandi Anda.')),
  );
}
}

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

          // TITLE
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

          // EMAIL
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

          // PASSWORD
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

          // BUTTON
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F5D43),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
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
