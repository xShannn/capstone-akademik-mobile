import 'package:flutter/material.dart';

import 'package:mobile_sekolah/shared/screens/profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SharedProfilePage(
      name: 'Ibu Siti',

      role: 'Parent',

      subtitle: 'Orang Tua Aisyah',

      initials: 'IS',

      showEditProfile: false,
    );
  }
}
