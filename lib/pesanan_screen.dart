import 'package:flutter/material.dart';

class PesananScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pesanan"), backgroundColor: const Color.fromARGB(255, 33, 150, 243)),
      body: Center(
        child: Text("Halaman Pesanan"),
      ),
    );
  }
}
