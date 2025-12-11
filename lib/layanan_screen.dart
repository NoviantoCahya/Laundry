import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LayananScreen extends StatelessWidget {
  const LayananScreen({super.key});

  /// FORMAT RUPIAH
  String formatRupiah(dynamic number) {
    if (number == null) return "0";
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => "${m[1]}.",
        );
  }

  /// TAMPILKAN HARGA
  String tampilkanHarga(Map<String, dynamic> item) {
    final hargaMin = item["hargaMin"];
    final hargaMax = item["hargaMax"];
    final satuan = item["satuan"];

    if (hargaMax == null || hargaMax == 0) {
      return "Rp ${formatRupiah(hargaMin)}/$satuan";
    }

    return "Rp ${formatRupiah(hargaMin)} - ${formatRupiah(hargaMax)}/$satuan";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      /// PAKAI GRADIENT PREMIUM DI APPBAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Layanan & Harga",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      /// BACKGROUND GRADIENT PREMIUM
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A90E2), // biru atas
              Color(0xFF70B2FF), // biru tengah
              Color(0xFFE8F0FF), // biru terang bawah
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("layanan").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "Belum ada layanan",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                );
              }

              final layanan = snapshot.data!.docs;

              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                itemCount: layanan.length,
                itemBuilder: (context, index) {
                  final item = layanan[index].data() as Map<String, dynamic>;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _LayananItem(
                      title: item["nama"],
                      subtitle: tampilkanHarga(item),
                    ),
                  );
                },
              );
            },
          ),
        ),
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
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // ICON LAUNDRY PREMIUM
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.local_laundry_service,
                  size: 32,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(width: 16),

              // TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // HARGA
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
