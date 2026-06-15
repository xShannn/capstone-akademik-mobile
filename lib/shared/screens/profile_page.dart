import 'package:flutter/material.dart';

import 'package:mobile_sekolah/services/auth_service.dart';

class SharedProfilePage extends StatelessWidget {
  final String name;

  final String role;

  final String subtitle;

  final String initials;

  final VoidCallback? onEditProfile;
  final bool showEditProfile;

  const SharedProfilePage({
    super.key,

    required this.name,

    required this.role,

    required this.subtitle,

    required this.initials,

    this.onEditProfile,
    this.showEditProfile = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,

              color: const Color(0xFF093FB4),

              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 32),

                  child: Column(
                    children: [
                      Container(
                        width: 90,

                        height: 90,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          color: const Color(0xFF3B68C8),

                          border: Border.all(color: Colors.white, width: 3),
                        ),

                        child: Center(
                          child: Text(
                            initials,

                            style: const TextStyle(
                              color: Colors.white,

                              fontSize: 30,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        name,

                        style: const TextStyle(
                          color: Colors.white,

                          fontSize: 22,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),

                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Text(
                          '$role - $subtitle',

                          style: const TextStyle(
                            color: Colors.white,

                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                children: [
                  if (showEditProfile)
                    _menuTile(
                      icon: Icons.person,

                      title: 'Edit Profile',

                      onTap: onEditProfile,
                    ),

                  _menuTile(icon: Icons.lock, title: 'Change Password'),

                  _menuTile(icon: Icons.notifications, title: 'Notifications'),

                  _menuTile(icon: Icons.help, title: 'Help & Support'),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,

                    height: 55,

                    child: ElevatedButton(
                      onPressed: () async {
                        await AuthService.logout(context);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFDE8E8),

                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),

                      child: const Text(
                        'Logout',

                        style: TextStyle(
                          color: Color(0xFFEF4444),

                          fontSize: 16,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,

    required String title,

    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF093FB4)),

      title: Text(title),

      trailing: const Icon(Icons.arrow_forward_ios),

      onTap: onTap,
    );
  }
}
