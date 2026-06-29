import 'package:flutter/material.dart';
import 'package:mobile_sekolah/features/student/screens/edit_profile_page.dart';
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
        final name =
            user?['name']?.toString() ??
            user?['username']?.toString() ??
            'Student';
        final role = user?['role']?.toString() ?? 'Student';
        final subtitle =
            user?['class_name']?.toString() ??
            user?['student_class']?.toString() ??
            '';
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
          initials: initials.isEmpty ? 'ST' : initials,
          onEditProfile: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfilePage()),
            );
          },
        );
      },
    );
  }
}
