import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto', // Kamu bisa mengganti fontnya nanti
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Menyimpan state role yang sedang dipilih
  String selectedRole = 'Teacher'; 

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
              
              // Tempat Logo (Silakan ganti dengan Image.asset jika logo sudah ada)
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
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
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              
              // Input Email
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  filled: true,
                  fillColor: const Color(0xFFEBEBEB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                ),
              ),
              const SizedBox(height: 16),
              
              // Input Password
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: const Color(0xFFEBEBEB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                ),
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
                ],
              ),
              const SizedBox(height: 32),
              
              // Tombol Login
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Logika login diletakkan di sini
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F42B3), // Warna biru gelap
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'BUTTON',
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.white
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
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
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
              color: isSelected ? const Color(0xFF0F42B3) : Colors.grey.shade400,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              role,
              style: TextStyle(
                color: isSelected ? const Color(0xFF0F42B3) : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}