import 'package:flutter/material.dart';
import 'layanan_screen.dart';
import 'pemesanan_screen.dart';
import 'pembayaran_screen.dart';

class BerandaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Container(
            height: 120,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text("")),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.list_alt, size: 40, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LayananScreen()),
                      );
                    },
                  ),
                  Text("Layanan\n& Harga", textAlign: TextAlign.center),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.add_shopping_cart,
                        size: 40, color: Colors.green),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PemesananScreen()),
                      );
                    },
                  ),
                  Text("Pemesanan"),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.payment, size: 40, color: Colors.orange),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PembayaranScreen(
                            nama: "Belum diisi",
                            alamat: "Belum diisi",
                            layanan: "Belum dipilih",
                          ),
                        ),
                      );
                    },
                  ),
                  Text("Pembayaran"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
