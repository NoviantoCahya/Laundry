import 'package:flutter/material.dart';

class LayananScreen extends StatelessWidget {
  const LayananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F0FA),

      /// HEADER BIRU ATAS
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,

        // === BACK ICON JADI PUTIH ===
        iconTheme: const IconThemeData(color: Colors.white),

        title: const Text(
          "Layanan & Harga",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      /// ISI HALAMAN
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _LayananItem(
            title: "Cuci Kering",
            subtitle: "Rp 10.000 / kg",
          ),
          SizedBox(height: 10),
          _LayananItem(
            title: "Cuci Setrika",
            subtitle: "Rp 15.000 / kg",
          ),
          SizedBox(height: 10),
          _LayananItem(
            title: "Cuci Sepatu",
            subtitle: "Rp 25.000 / pasang",
          ),
        ],
      ),
    );
  }
}

class _LayananItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _LayananItem({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
