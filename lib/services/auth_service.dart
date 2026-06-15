import 'package:flutter/material.dart';

import 'package:mobile_sekolah/features/auth/screens/login_page.dart';

import 'package:mobile_sekolah/services/storage_service.dart';

class AuthService {
  static Future<void> logout(BuildContext context) async {
    await StorageService.clearAll();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,

      MaterialPageRoute(builder: (_) => const LoginPage()),

      (route) => false,
    );
  }
}
