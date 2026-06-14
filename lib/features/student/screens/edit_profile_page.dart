import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controller untuk mengisi nilai default pada form
  final TextEditingController _nameController = TextEditingController(
    text: 'Mas Akhlis K.',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'akhlis.k@sman1.sch.id',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '+62 812-3456-7890',
  );
  final TextEditingController _addressController = TextEditingController(
    text: 'Jl. Merdeka No. 12, Semarang',
  );

  @override
  void dispose() {
    // Pastikan controller dihapus dari memori saat halaman ditutup
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F42B3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    'Full Name',
                    _nameController,
                    isReadOnly: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField('Email', _emailController),
                  const SizedBox(height: 16),
                  _buildTextField('Phone', _phoneController),
                  const SizedBox(height: 16),
                  _buildTextField('Address', _addressController),

                  const SizedBox(height: 40),
                  _buildSaveButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // WIDGET HEADER (Warna Biru + Avatar)
  // ==========================================
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0F42B3),
      padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF3B68C8),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 3,
              ),
            ),
            child: const Center(
              child: Text(
                'AK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Mas Akhlis K.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Student - X IPA 1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ==========================================
  // WIDGET CUSTOM TEXT FIELD
  // ==========================================
  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isReadOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: isReadOnly, // Mematikan fungsi ketik jika true
          style: TextStyle(
            // Warna teks agak pudar jika tidak bisa diedit
            color: isReadOnly ? Colors.grey.shade600 : const Color(0xFF1A1A24),
          ),
          decoration: InputDecoration(
            filled: true,
            // Warna latar abu-abu jika tidak bisa diedit
            fillColor: isReadOnly ? Colors.grey.shade100 : Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF0F42B3),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // WIDGET TOMBOL SAVE
  // ==========================================
  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          // Logika untuk mengirim data ke Backend (API) diletakkan di sini
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0F42B3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Save Changes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
