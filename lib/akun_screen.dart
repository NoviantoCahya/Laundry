import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

// ===========================================================
// APPBAR TRANSPARAN PUTIH PREMIUM
// ===========================================================
AppBar buildTransparentWhiteAppBar(String title) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white.withOpacity(0.0),
    centerTitle: true,
    title: const Text(
      "",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}

// ===========================================================
// WIDGET MENU PREMIUM CARD
// ===========================================================
class PremiumMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;

  const PremiumMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade500),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================
// HALAMAN-HALAMAN MENU (TETAP SAMA)
// ===========================================================
class GantiPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTransparentWhiteAppBar("Ganti Password"),
      body: const Center(child: Text("Halaman Ganti Password")),
    );
  }
}

class UlasanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTransparentWhiteAppBar("Beri Ulasan"),
      body: const Center(child: Text("Halaman Beri Ulasan")),
    );
  }
}

class TentangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTransparentWhiteAppBar("Tentang Matik Laundry"),
      body: const Center(child: Text("Informasi tentang aplikasi laundry")),
    );
  }
}

class ReferralPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTransparentWhiteAppBar("Kode Referral"),
      body: const Center(child: Text("Halaman Bagikan Kode Referral")),
    );
  }
}

// ===========================================================
// AKUN SCREEN PREMIUM (FULL GRADIENT + FIREBASE USER)
// ===========================================================
class AkunScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildTransparentWhiteAppBar("Akun"),
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // GRADIENT BIRU PREMIUM FULLSCREEN
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A90E2),
              Color(0xFF70B2FF),
              Color(0xFFE8F0FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(height: 10),

              // =======================================================
              // HEADER AKUN PREMIUM DENGAN NAMA & EMAIL
              // =======================================================
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    // FOTO PROFIL
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.4),
                      ),
                      child: const Icon(Icons.person,
                          size: 40, color: Colors.white),
                    ),
                    const SizedBox(width: 16),

                    // NAMA & EMAIL
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? "Pengguna",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.email ?? "Tidak ada email",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // =======================================================
              // MENU AKUN
              // =======================================================

              PremiumMenuTile(
                icon: Icons.person,
                title: "Profil Saya",
                onTap: () {},
                color: Colors.blue,
              ),

              PremiumMenuTile(
                icon: Icons.lock_reset_rounded,
                title: "Ganti Password",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => GantiPasswordPage()),
                ),
                color: Colors.orange,
              ),

              PremiumMenuTile(
                icon: Icons.star_rate_rounded,
                title: "Beri Ulasan",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UlasanPage()),
                ),
                color: Colors.amber,
              ),

              PremiumMenuTile(
                icon: Icons.share_rounded,
                title: "Kode Referral",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ReferralPage()),
                ),
                color: Colors.purple,
              ),

              PremiumMenuTile(
                icon: Icons.info_rounded,
                title: "Tentang Aplikasi",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TentangPage()),
                ),
                color: Colors.green,
              ),

              PremiumMenuTile(
                icon: Icons.exit_to_app_rounded,
                title: "Keluar",
                color: Colors.red,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
