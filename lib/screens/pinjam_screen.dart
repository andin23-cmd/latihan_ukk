import 'package:flutter/material.dart';

class PesananScreen extends StatelessWidget {
  final Map<String, dynamic> alat;
  
  const PesananScreen({super.key, required this.alat});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.grey[200],

  /// ===== APPBAR =====
  appBar: AppBar(
    backgroundColor: const Color(0xFF1A2C22),
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.pop(context),
    ),
    title: const Row(
      children: [
        Icon(Icons.book, color: Colors.amber),
        SizedBox(width: 8),
        Text(
          "Pesanan Anda",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),

  /// ===== BODY =====
  body: Column(
    children: [
      Expanded(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// DATA PESANAN
              const Text(
                "Data Pesanan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                "Ringkasan pesanan Barang anda",
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),

              _box(
                title: "Sabtu, 3 Januari 2026",
                subtitle: "Headphone 2",
                button: true,
              ),

              const SizedBox(height: 16),

              /// PENGEMBALIAN
              const Text(
                "Pengembalian",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              _box(
                title: "Rabu, 6 Januari 2026",
                subtitle: "Headphone 2",
              ),

              const SizedBox(height: 16),

              /// PEMESAN
              const Text(
                "Pemesan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              _box(
                title: "Andin Ramadani",
                subtitle: "+9878174678",
              ),
            ],
          ),
        ),
      ),

      /// ===== FOOTER =====
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A2C22),
              Color(0xFF274635),
            ],
          ),
        ),
        child: Column(
          children: [

            /// JANGKA PINJAM
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Jangka Pinjam",
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                  "3 Hari",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// BUTTON PINJAM
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF4B400),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Pinjam",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

}
}

/// ===== WIDGET BOX =====
Widget _box({
required String title,
required String subtitle,
bool button = false,
}) {
return Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: Colors.grey[100],
borderRadius: BorderRadius.circular(10),
border: Border.all(color: Colors.grey.shade300),
),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(title),
Text(
subtitle,
style: const TextStyle(fontSize: 12),
),
],
),
if (button)
Container(
padding: const EdgeInsets.symmetric(
horizontal: 12,
vertical: 6,
),
decoration: BoxDecoration(
color: const Color(0xFFF4B400),
borderRadius: BorderRadius.circular(8),
),
child: const Text(
"Ubah",
style: TextStyle(fontSize: 12),
),
),
],
),
);
}
