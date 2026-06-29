import 'package:flutter/material.dart';
import '../services/admin_service.dart';

class ManageClassesPage extends StatefulWidget {
  const ManageClassesPage({super.key});

  @override
  State<ManageClassesPage> createState() => _ManageClassesPageState();
}

class _ManageClassesPageState extends State<ManageClassesPage> {
  late Future<List<Map<String, dynamic>>> _classesFuture;

  @override
  void initState() {
    super.initState();
    _fetchClasses();
  }

  void _fetchClasses() {
    setState(() {
      _classesFuture = AdminService.getClasses();
    });
  }

  Future<void> _showClassDialog({Map<String, dynamic>? classItem}) async {
    final bool isEdit = classItem != null;

    // FIX: Menggunakan kunci nama_kelas dan level sesuai backend Laravel
    final TextEditingController nameController = TextEditingController(
      text: isEdit ? (classItem['nama_kelas']?.toString() ?? '') : '',
    );
    final TextEditingController roomController = TextEditingController(
      text: isEdit ? (classItem['level']?.toString() ?? '') : '',
    );

    await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Kelas' : 'Tambah Kelas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kelas',
                  hintText: 'Contoh: 10 IPA 1',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: roomController,
                decoration: const InputDecoration(
                  labelText: 'Level / Tingkat',
                  hintText: 'Contoh: 10',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final room = roomController.text.trim();

                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nama kelas tidak boleh kosong'),
                    ),
                  );
                  return;
                }

                Navigator.pop(context, true);

                // FIX: Request payload yang dikirim ke Laravel juga disesuaikan
                final data = {'nama_kelas': name, 'level': room};

                Map<String, dynamic> response;
                if (isEdit) {
                  final id = classItem['id'];
                  response = await AdminService.updateClass(id, data);
                } else {
                  response = await AdminService.createClass(data);
                }

                if (!mounted) return;

                if (response['success']) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        response['message'] ?? 'Berhasil menyimpan data',
                      ),
                    ),
                  );
                  _fetchClasses();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        response['message'] ?? 'Gagal menyimpan data',
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF093FB4),
                foregroundColor: Colors.white,
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteClass(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Kelas'),
          content: const Text('Apakah Anda yakin ingin menghapus kelas ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      final response = await AdminService.deleteClass(id);
      if (!mounted) return;

      if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message'] ?? 'Berhasil menghapus kelas'),
          ),
        );
        _fetchClasses();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message'] ?? 'Gagal menghapus kelas'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Classes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF093FB4),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF093FB4),
        onPressed: () => _showClassDialog(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _classesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final classes = snapshot.data ?? [];
          if (classes.isEmpty) {
            return const Center(child: Text('Belum ada kelas terdaftar.'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              _fetchClasses();
              await _classesFuture;
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: classes.length,
              itemBuilder: (context, index) {
                final item = classes[index];
                final id = item['id'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // FIX: Mapping nama sesuai kolom database Laravel
                              item['nama_kelas']?.toString() ?? 'Tanpa Nama',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              // FIX: Mapping level sesuai kolom database Laravel
                              'Level: ${item['level']?.toString() ?? '-'}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showClassDialog(classItem: item),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: id != null
                                ? () => _deleteClass(id)
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
