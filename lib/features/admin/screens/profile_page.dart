import 'package:flutter/material.dart';
import 'package:mobile_sekolah/services/storage_service.dart';
import 'package:mobile_sekolah/shared/screens/profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: StorageService.getUser(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final name = user?['name']?.toString() ?? user?['username']?.toString() ?? 'Admin';
        final role = user?['role']?.toString() ?? 'Administrator';
        final subtitle = user?['school_name']?.toString() ?? 'Sekolah';
        
        final initials = name
            .split(' ')
            .where((part) => part.isNotEmpty)
            .map((part) => part[0])
            .take(2)
            .join()
            .toUpperCase();

        return SharedProfilePage(
          name: name,
          role: role,
          subtitle: subtitle,
          initials: initials.isEmpty ? 'AD' : initials,
          showEditProfile: false,
        );
      },
    );
  }
}