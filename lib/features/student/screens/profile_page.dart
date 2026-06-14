import 'package:flutter/material.dart';
// Import file login untuk fungsi Sign Out (sesuaikan path-nya jika berbeda)
import 'package:mobile_sekolah/features/auth/screens/login_page.dart';
import 'package:mobile_sekolah/features/student/screens/edit_profile_page.dart'; // path edit profile

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- PERUBAHANNYA ADA DI SINI ---
      // SingleChildScrollView membungkus keseluruhan halaman dari atas
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header kotak biru ikut masuk ke dalam area scroll
            _buildHeader(),

            // Bungkus menu dengan Padding (Tidak pakai Expanded lagi)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    icon: Icons.person,
                    title: 'Edit Profile',
                    iconColor: const Color(0xFF4A72B2), // Biru kalem
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfilePage(),
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.lock,
                    title: 'Change Password',
                    iconColor: const Color(0xFFB59F4A), // Emas/Kuning kalem
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.notifications,
                    title: 'Notification Settings',
                    iconColor: const Color(0xFFD9A05B), // Warna emas/kuning
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.help,
                    title: 'Help & Support',
                    iconColor: const Color(0xFFD34C4C), // Merah
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.info,
                    title: 'App Version',
                    iconColor: const Color(0xFF6B82A4), // Biru keabuan
                    trailingText: 'v2.4.0',
                    hideChevron: true,
                  ),
                  const SizedBox(height: 40),

                  // Tombol Sign Out
                  _buildSignOutButton(context),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // SECTION 1: HEADER PROFIL (Warna Biru)
  // ==========================================
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0F42B3), // Biru utama aplikasi
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 32.0),
          child: Column(
            children: [
              // Lingkaran Avatar
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF3B68C8), // Biru sedikit lebih muda
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 3,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'AK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Nama User
              const Text(
                'Mas Akhlis K.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Badge Role & Kelas
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Student - X IPA 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // SECTION 2: WIDGET ITEM MENU
  // ==========================================
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color iconColor,
    String? trailingText,
    bool hideChevron = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          children: [
            // Icon dengan background rounded
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FE), // Abu-abu sangat terang
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),

            // Judul Menu
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A24),
                ),
              ),
            ),

            // Teks tambahan di kanan (seperti 'Light' atau 'v2.4.0')
            if (trailingText != null) ...[
              Text(
                trailingText,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
            ],

            // Icon Panah Kanan (Chevron)
            if (!hideChevron)
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Garis pemisah antar menu
  Widget _buildDivider() {
    return Divider(color: Colors.grey.shade200, height: 1, thickness: 1);
  }

  // ==========================================
  // SECTION 3: TOMBOL SIGN OUT
  // ==========================================
  Widget _buildSignOutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          // Logika Sign Out: Hapus semua tumpukan halaman dan kembali ke Login
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) =>
                false, // Menghapus seluruh history routing (agar tidak bisa di-back)
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(
            0xFFFDE8E8,
          ), // Background merah super muda
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Sign Out',
          style: TextStyle(
            color: Color(0xFFD34C4C), // Teks merah
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
