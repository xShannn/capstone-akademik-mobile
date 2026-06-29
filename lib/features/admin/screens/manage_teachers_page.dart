import 'package:flutter/material.dart';
import '../services/admin_service.dart';

class ManageTeachersPage extends StatefulWidget {
  const ManageTeachersPage({super.key});

  @override
  State<ManageTeachersPage> createState() => _ManageTeachersPageState();
}

class _ManageTeachersPageState extends State<ManageTeachersPage> {
  List<Map<String, dynamic>> _allTeachers = [];
  List<Map<String, dynamic>> _filteredTeachers = [];
  bool _isLoading = true;
  String _errorMessage = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTeachers();
  }

  Future<void> _fetchTeachers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      final teachers = await AdminService.getTeachers();
      setState(() {
        _allTeachers = teachers;
        _filteredTeachers = teachers;
        _isLoading = false;
      });
      if (_searchController.text.isNotEmpty) {
        _filterTeachers(_searchController.text);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat data guru.';
        _isLoading = false;
      });
    }
  }

  void _filterTeachers(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredTeachers = _allTeachers;
      } else {
        _filteredTeachers = _allTeachers.where((teacher) {
          final name = (teacher['user']?['name'] ?? teacher['name'] ?? '')
              .toString()
              .toLowerCase();
          final nip = (teacher['nip'] ?? '-').toString().toLowerCase();
          return name.contains(query.toLowerCase()) ||
              nip.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  // POP-UP NOTIFIKASI SNACKBAR PROFESIONAL
  void _showCustomSnackBar(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isSuccess
            ? const Color(0xFF10B981)
            : const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _showTeacherDialog({Map<String, dynamic>? teacherItem}) async {
    final bool isEdit = teacherItem != null;
    final nameController = TextEditingController(
      text: isEdit ? (teacherItem['user']?['name'] ?? '') : '',
    );
    final nipController = TextEditingController(
      text: isEdit ? (teacherItem['nip']?.toString() ?? '') : '',
    );

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Guru' : 'Tambah Guru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Guru'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: nipController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'NIP'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) return;

                Navigator.pop(context);
                final data = {'name': name, 'nip': nipController.text.trim()};

                Map<String, dynamic> response = isEdit
                    ? await AdminService.updateTeacher(teacherItem['id'], data)
                    : await AdminService.createTeacher(data);

                if (response['success'] == true || response['data'] != null) {
                  _showCustomSnackBar(
                    response['message'] ?? 'Data guru berhasil disimpan',
                    true,
                  );
                  _fetchTeachers();
                } else {
                  _showCustomSnackBar(
                    response['message'] ?? 'Gagal memproses data',
                    false,
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

  Future<void> _deleteTeacher(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Guru'),
        content: const Text('Yakin ingin menghapus guru ini?'),
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
      ),
    );

    if (confirm == true) {
      final response = await AdminService.deleteTeacher(id);
      if (response['success'] == true) {
        _showCustomSnackBar('Data guru berhasil dihapus', true);
        _fetchTeachers();
      } else {
        _showCustomSnackBar(
          response['message'] ?? 'Gagal menghapus data',
          false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Teachers',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF093FB4),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF093FB4),
        onPressed: () => _showTeacherDialog(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterTeachers,
                    decoration: InputDecoration(
                      hintText: 'Cari nama guru atau NIP...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF093FB4),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: _filteredTeachers.isEmpty
                      ? const Center(child: Text('Tidak ada data guru.'))
                      : RefreshIndicator(
                          onRefresh: _fetchTeachers,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: _filteredTeachers.length,
                            itemBuilder: (context, index) {
                              final item = _filteredTeachers[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['user']?['name']?.toString() ??
                                                'Tanpa Nama',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'NIP: ${item['nip']?.toString() ?? '-'}',
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () => _showTeacherDialog(
                                            teacherItem: item,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () =>
                                              _deleteTeacher(item['id']),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
