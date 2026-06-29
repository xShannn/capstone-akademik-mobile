import 'package:flutter/material.dart';

import 'package:mobile_sekolah/services/api_service.dart';
import 'package:mobile_sekolah/services/storage_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isLoading = true;

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final addressController = TextEditingController();

  String role = '';

  String subtitle = '';

  @override
  void initState() {
    super.initState();

    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final user = await StorageService.getUser();

      if (user != null) {
        nameController.text = user['nama_lengkap'] ?? user['name'] ?? '';

        emailController.text = user['email'] ?? '';

        phoneController.text = user['nomor_telepon'] ?? '';

        addressController.text = user['alamat'] ?? '';

        role = user['role'] ?? 'Student';

        subtitle = user['class_name'] ?? '';
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> saveProfile() async {
    try {
      final token = await StorageService.getToken();

      if (token == null) return;

      final result = await ApiService.putData(
        endpoint: '/profile',

        token: token,

        data: {
          'email': emailController.text,

          'nomor_telepon': phoneController.text,

          'alamat': addressController.text,
        },
      );

      if (!mounted) return;

      if (result['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile berhasil diupdate'),

            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'].toString()),

            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    nameController.dispose();

    emailController.dispose();

    phoneController.dispose();

    addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final initials = nameController.text
        .split(' ')
        .map((e) => e[0])
        .take(2)
        .join()
        .toUpperCase();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F42B3),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Edit Profil', style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,

              color: const Color(0xFF0F42B3),

              padding: const EdgeInsets.all(25),

              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,

                    backgroundColor: Colors.white,

                    child: Text(
                      initials,

                      style: const TextStyle(
                        fontSize: 28,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    nameController.text,

                    style: const TextStyle(
                      color: Colors.white,

                      fontSize: 22,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '$role $subtitle',

                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                children: [
                  buildField('Nama', nameController, true),

                  const SizedBox(height: 15),

                  buildField('Email', emailController, false),

                  const SizedBox(height: 15),

                  buildField('Telepon', phoneController, false),

                  const SizedBox(height: 15),

                  buildField('Alamat', addressController, false),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,

                    height: 55,

                    child: ElevatedButton(
                      onPressed: saveProfile,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F42B3),
                      ),

                      child: const Text('Simpan'),
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

  Widget buildField(
    String label,

    TextEditingController controller,

    bool readOnly,
  ) {
    return TextField(
      controller: controller,

      readOnly: readOnly,

      decoration: InputDecoration(
        labelText: label,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
