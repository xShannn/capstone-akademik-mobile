import 'package:flutter/material.dart';

import 'package:mobile_sekolah/features/auth/screens/login_page.dart';

import 'package:mobile_sekolah/features/student/screens/main_student_page.dart';

import 'package:mobile_sekolah/features/teacher/screens/home_teacher_page.dart';

import 'package:mobile_sekolah/features/parent/screens/home_parent_page.dart';

import 'package:mobile_sekolah/features/admin/screens/home_admin_page.dart';

import 'package:mobile_sekolah/services/storage_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await StorageService.getToken();

    final user = await StorageService.getUser();

    if (!mounted) return;

    if (token == null || user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );

      return;
    }

    final role = user['role'];

    switch (role) {
      case 'student':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainStudentPage()),
        );

        break;

      case 'teacher':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeTeacherPage()),
        );

        break;

      case 'parent':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeParentPage()),
        );

        break;

      case 'admin':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeAdminPage()),
        );

        break;

      default:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF093FB4),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(Icons.school, color: Colors.white, size: 90),

            const SizedBox(height: 20),

            const Text(
              'Baitul Insan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
