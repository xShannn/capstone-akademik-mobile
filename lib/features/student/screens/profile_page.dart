import 'package:flutter/material.dart';

import 'package:mobile_sekolah/features/student/screens/edit_profile_page.dart';

import 'package:mobile_sekolah/shared/screens/profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedProfilePage(
      name: 'Mas Akhlis K.',

      role: 'Student',

      subtitle: 'X IPA 1',

      initials: 'AK',

      onEditProfile: () {
        Navigator.push(
          context,

          MaterialPageRoute(builder: (_) => const EditProfilePage()),
        );
      },
    );
  }
}
