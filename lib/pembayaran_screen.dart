import 'package:flutter/material.dart';
import 'riwayat_screen.dart';

class PembayaranScreen extends StatelessWidget {
  final String nama;
  final String alamat;
  final String layanan;

  PembayaranScreen({
    required this.nama,
    required this.alamat,
    required this.layanan,
  });

  void _selesaikanPesanan(BuildContext context) {
    RiwayatScreen.riwayatPesanan.add({
      "nama": nama,
      "alamat": alamat,
      "layanan": layanan,
      "metode": "QRIS",
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => RiwayatScreen()),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Pesanan berhasil disimpan ke Riwayat"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8EEF8), // warna background halus
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Pembayaran",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Text(
                "Qris",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // KOTAK QR
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/qris.png",
                    height: 170,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        "QRIS tidak ditemukan",
                        style: TextStyle(color: Colors.red),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // TOMBOL SIMPAN
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => _selesaikanPesanan(context),
                  child: const Text(
                    "Simpan",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
