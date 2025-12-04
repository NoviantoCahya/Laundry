import 'package:flutter/material.dart';

class RiwayatScreen extends StatefulWidget {
  static List<Map<String, String>> riwayatPesanan = [];

  @override
  _RiwayatScreenState createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Pesanan"),
        backgroundColor: Colors.blue,
      ),
      body: RiwayatScreen.riwayatPesanan.isEmpty
          ? Center(child: Text("Belum ada riwayat pesanan"))
          : ListView.builder(
              itemCount: RiwayatScreen.riwayatPesanan.length,
              itemBuilder: (context, index) {
                final item = RiwayatScreen.riwayatPesanan[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(item["layanan"] ?? ""),
                    subtitle: Text(
                        "Nama: ${item["nama"]}\nAlamat: ${item["alamat"]}\nMetode: ${item["metode"]}"),
                  ),
                );
              },
            ),
    );
  }
}
