import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PembayaranScreen extends StatelessWidget {
  final String nama;
  final String alamat;
  final String layanan;

  PembayaranScreen({
    required this.nama,
    required this.alamat,
    required this.layanan,
  });

  // Fungsi kirim WhatsApp
  void _kirimWhatsApp() async {
    final nomor = "62881036567620";
    final pesan = Uri.encodeComponent(
        "Halo Admin Laundry, saya sudah melakukan pembayaran via QRIS.\n\n"
        "Nama: $nama\nAlamat: $alamat\nLayanan: $layanan\n\n"
        "Berikut saya kirim bukti pembayarannya.");
    final url = "https://wa.me/$nomor?text=$pesan";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Pembayaran",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,

        /// GRADIENT FULLSCREEN
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                const Text(
                  "Silakan screenshot QRIS di bawah\nuntuk melakukan pembayaran",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 25),

                // CARD QRIS PREMIUM
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "QRIS Pembayaran",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          "assets/qris.png",
                          height: 260,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // TOMBOL KONFIRMASI
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _kirimWhatsApp,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      "Konfirmasi Pembayaran",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
