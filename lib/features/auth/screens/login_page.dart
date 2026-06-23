import 'package:flutter/material.dart';
import 'package:mobile_sekolah/features/auth/widgets/custom_text_field.dart';
import 'package:mobile_sekolah/features/student/screens/main_student_page.dart';
import 'package:mobile_sekolah/features/teacher/screens/home_teacher_page.dart';
import 'package:mobile_sekolah/features/parent/screens/home_parent_page.dart';
import 'package:mobile_sekolah/features/admin/screens/home_admin_page.dart';
import 'package:mobile_sekolah/services/api_service.dart';
import 'package:mobile_sekolah/services/storage_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Menyimpan state role yang sedang dipilih
  String selectedRole = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // Tempat Logo
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: const Icon(Icons.shield, size: 80, color: Colors.green),
              ),
              const SizedBox(height: 32),

              // Heading
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A24),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in to your account',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // Input Email menggunakan Custom Widget
              CustomTextField(
                hintText: 'Email Address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Input Password menggunakan Custom Widget
              CustomTextField(
                hintText: 'Password',
                isObscure: true, // Menyensor teks password
                controller: _passwordController,
              ),
              const SizedBox(height: 24),

              // Label Role
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Role',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A24),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Opsi Pilihan Role
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRoleButton('Teacher'),
                  const SizedBox(width: 8),
                  _buildRoleButton('Student'),
                  const SizedBox(width: 8),
                  _buildRoleButton('Parent'),
                  const SizedBox(width: 8),
                  _buildRoleButton('Admin'),
                ],
              ),
              const SizedBox(height: 32),

              // Tombol Login
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text;

                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Email tidak boleh kosong'),
                        ),
                      );
                      return;
                    }

                    if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password tidak boleh kosong'),
                        ),
                      );
                      return;
                    }

                    if (selectedRole.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Role belum dipilih')),
                      );
                      return;
                    }

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                    );

                    final result = await ApiService.login(
                      role: selectedRole,
                      email: email,
                      password: password,
                    );

                    if (!mounted) return;

                    Navigator.of(context, rootNavigator: true).pop();

                    if (result['success'] == true) {
                      final data = result['data'];

                      final token = data['token'];

                      final user = data['user'];

                      await StorageService.saveToken(token);

                      await StorageService.saveUser(user);

                      final role = user['role'];

                      if (role == 'student') {
                        Navigator.pushReplacement(
                          context,

                          MaterialPageRoute(
                            builder: (_) => const MainStudentPage(),
                          ),
                        );
                      } else if (role == 'teacher') {
                        Navigator.pushReplacement(
                          context,

                          MaterialPageRoute(
                            builder: (_) => const HomeTeacherPage(),
                          ),
                        );
                      } else if (role == 'parent') {
                        Navigator.pushReplacement(
                          context,

                          MaterialPageRoute(
                            builder: (_) => const HomeParentPage(),
                          ),
                        );
                      } else if (role == 'admin') {
                        Navigator.pushReplacement(
                          context,

                          MaterialPageRoute(
                            builder: (_) => const HomeAdminPage(),
                          ),
                        );
                      }
                    } else {
                      final msg = result['message'] ?? 'Gagal login';

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(msg.toString())));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF0F42B3,
                    ), // Warna biru gelap
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Lupa Password
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Color(0xFF0F42B3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 60),

              // Footer
              const Text(
                'Baitul Insan v.1 • Secure Login',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Widget custom untuk membuat tombol role yang bisa berubah warna saat dipilih
  Widget _buildRoleButton(String role) {
    bool isSelected = selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRole = role; // Mengubah state role saat diklik
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEDF4FF) : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF0F42B3)
                  : Colors.grey.shade400,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              role,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF0F42B3)
                    : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
