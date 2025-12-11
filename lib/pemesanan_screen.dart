import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ← WAJIB ADA

class PemesananScreen extends StatefulWidget {
  const PemesananScreen({super.key});

  @override
  State<PemesananScreen> createState() => _PemesananScreenState();
}

class _PemesananScreenState extends State<PemesananScreen> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  String? selectedLayanan;
  int? selectedHargaMin;
  int? selectedHargaMax;
  String? selectedSatuan;

  String formatRupiah(dynamic number) {
    if (number == null) return "0";
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (m) => "${m[1]}.",
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      /// APPBAR TRANSPARENT
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Pemesanan",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      /// GRADIENT FULLSCREEN
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                /// CARD FORM
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      buildInput("Nama", namaController),
                      const SizedBox(height: 16),

                      buildInput("No. Telepon", hpController,
                          keyboard: TextInputType.phone),
                      const SizedBox(height: 16),

                      buildInput("Alamat", alamatController, maxLines: 2),
                      const SizedBox(height: 18),

                      /// ================= DROPDOWN FIRESTORE =================
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("layanan")
                            .orderBy("nama")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final docs = snapshot.data!.docs;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Pilih Layanan",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedLayanan,
                                    isExpanded: true,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    hint: const Text("Pilih layanan"),
                                    items: docs.map((doc) {
                                      final data =
                                          doc.data() as Map<String, dynamic>;

                                      String hargaText = (data["hargaMax"] == 0)
                                          ? "Rp ${formatRupiah(data["hargaMin"])}/${data["satuan"]}"
                                          : "Rp ${formatRupiah(data["hargaMin"])} - Rp ${formatRupiah(data["hargaMax"])}/${data["satuan"]}";

                                      return DropdownMenuItem<String>(
                                        value: data["nama"],
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[100],
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Icon(
                                                Icons.local_laundry_service,
                                                color: Colors.blue[700],
                                                size: 22,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data["nama"],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    hargaText,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black54,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedLayanan = value;

                                        final chosen = docs.firstWhere((d) =>
                                            d["nama"].toString() == value);

                                        selectedHargaMin = chosen["hargaMin"];
                                        selectedHargaMax = chosen["hargaMax"];
                                        selectedSatuan = chosen["satuan"];
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      buildInput("Catatan", catatanController),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                /// TOMBOL SIMPAN
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: saveOrder,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF015FFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 6,
                    ),
                    child: const Text(
                      "Simpan Pemesanan",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// INPUT FIELD
  Widget buildInput(String label, TextEditingController controller,
      {TextInputType keyboard = TextInputType.text, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: Colors.black87),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// SIMPAN KE FIRESTORE
  Future<void> saveOrder() async {
    if (namaController.text.isEmpty ||
        hpController.text.isEmpty ||
        alamatController.text.isEmpty ||
        selectedLayanan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lengkapi semua data termasuk layanan!"),
        ),
      );
      return;
    }

    await FirebaseFirestore.instance.collection("pemesanan").add({
      "idUser": FirebaseAuth.instance.currentUser!.uid,
      "nama": namaController.text,
      "hp": hpController.text,
      "alamat": alamatController.text,
      "catatan": catatanController.text,
      "layanan": selectedLayanan,
      "hargaMin": selectedHargaMin,
      "hargaMax": selectedHargaMax,
      "satuan": selectedSatuan,
      "tanggal": DateTime.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pesanan berhasil disimpan")),
    );

    /// RESET INPUT
    namaController.clear();
    hpController.clear();
    alamatController.clear();
    catatanController.clear();

    setState(() {
      selectedLayanan = null;
    });
  }
}
