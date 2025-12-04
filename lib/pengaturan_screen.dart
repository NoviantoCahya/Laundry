import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart'; // pastikan file ini ada

// Dummy Page untuk setiap menu
class PrinterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Printer")),
      body: Center(child: Text("Halaman Printer")),
    );
  }
}

class AturPesanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Atur Pesan")),
      body: Center(child: Text("Halaman Atur Pesan")),
    );
  }
}

class GantiPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ganti Password")),
      body: Center(child: Text("Halaman Ganti Password")),
    );
  }
}

class UlasanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Beri Ulasan")),
      body: Center(child: Text("Halaman Beri Ulasan")),
    );
  }
}

class TentangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tentang Matik Laundry")),
      body: Center(child: Text("Informasi tentang aplikasi laundry")),
    );
  }
}

class ReferralPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kode Referral")),
      body: Center(child: Text("Halaman Bagikan Kode Referral")),
    );
  }
}

// ======================== MAIN PENGATURAN SCREEN ========================
class PengaturanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Printer"),
            trailing: Icon(Icons.chevron_right, color: Colors.blue),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PrinterPage()));
            },
          ),
          Divider(),
          ListTile(
            title: Text("Atur Pesan"),
            trailing: Icon(Icons.chevron_right, color: Colors.blue),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AturPesanPage()));
            },
          ),
          Divider(),
          ListTile(
            title: Text("Ganti Password"),
            trailing: Icon(Icons.chevron_right, color: Colors.blue),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => GantiPasswordPage()));
            },
          ),
          Divider(),
          ListTile(
            title: Text("Beri Ulasan"),
            trailing: Icon(Icons.chevron_right, color: Colors.blue),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => UlasanPage()));
            },
          ),
          Divider(),
          ListTile(
            title: Text("Tentang Matik Laundry"),
            trailing: Icon(Icons.chevron_right, color: Colors.blue),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => TentangPage()));
            },
          ),
          Divider(),
          ListTile(
            title: Text("Bagikan Kode Referral Anda"),
            trailing: Icon(Icons.chevron_right, color: Colors.blue),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ReferralPage()));
            },
          ),
          Divider(),
          ListTile(
            title: Text("Keluar"),
            trailing: Icon(Icons.exit_to_app, color: Colors.red),
            onTap: () async {
              await FirebaseAuth.instance.signOut();

              // Setelah signOut, authStateChanges() di main.dart
              // otomatis redirect ke LoginScreen
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
