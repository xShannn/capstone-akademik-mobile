import 'package:flutter/material.dart';
import '../services/admin_service.dart';

class ManageStudentsPage extends StatefulWidget {
  const ManageStudentsPage({super.key});

  @override
  State<ManageStudentsPage> createState() => _ManageStudentsPageState();
}

class _ManageStudentsPageState extends State<ManageStudentsPage> {
  List<Map<String, dynamic>> _allStudents = [];
  List<Map<String, dynamic>> _filteredStudents = [];
  List<Map<String, dynamic>> _allClasses =
      []; // Menyimpan daftar kelas dari database

  bool _isLoading = true;
  String _errorMessage = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Mengambil data Siswa dan data Kelas secara bersamaan
  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      final results = await Future.wait([
        AdminService.getStudents(),
        AdminService.getClasses(), // Mengambil data kelas untuk dropdown
      ]);

      setState(() {
        _allStudents = results[0];
        _filteredStudents = results[0];
        _allClasses = results[1];
        _isLoading = false;
      });

      if (_searchController.text.isNotEmpty) {
        _filterStudents(_searchController.text);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat data.';
        _isLoading = false;
      });
    }
  }

  void _filterStudents(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredStudents = _allStudents;
      } else {
        _filteredStudents = _allStudents.where((student) {
          final name = (student['user']?['name'] ?? student['name'] ?? '')
              .toString()
              .toLowerCase();
          final className = (student['classroom']?['nama_kelas'] ?? '-')
              .toString()
              .toLowerCase();
          return name.contains(query.toLowerCase()) ||
              className.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

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

  Future<void> _showStudentDialog({Map<String, dynamic>? studentItem}) async {
    final bool isEdit = studentItem != null;
    final nameController = TextEditingController(
      text: isEdit ? (studentItem['user']?['name'] ?? '') : '',
    );
    final emailController = TextEditingController(
      text: isEdit ? (studentItem['user']?['email'] ?? '') : '',
    );

    // Variabel untuk menyimpan ID Kelas yang dipilih di Dropdown
    int? selectedClassId;
    if (isEdit && studentItem['classroom'] != null) {
      selectedClassId = studentItem['classroom']['id'];
    }

    await showDialog(
      context: context,
      builder: (context) {
        // Menggunakan StatefulBuilder agar Dropdown bisa di-update/klik di dalam Dialog
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(isEdit ? 'Edit Siswa' : 'Tambah Siswa'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Siswa',
                      ),
                    ),
                    const SizedBox(height: 12),

                    // DROPDOWN KELAS
                    DropdownButtonFormField<int>(
                      value: selectedClassId,
                      decoration: const InputDecoration(
                        labelText: 'Pilih Kelas',
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Belum ada kelas dipilih'),
                      items: _allClasses.map((kelas) {
                        return DropdownMenuItem<int>(
                          value: kelas['id'] as int,
                          child: Text(
                            '${kelas['level'] ?? ''} - ${kelas['nama_kelas'] ?? ''}',
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedClassId = value;
                        });
                      },
                    ),

                    const SizedBox(height: 12),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final name = nameController.text.trim();
                    if (name.isEmpty) {
                      _showCustomSnackBar(
                        'Nama siswa tidak boleh kosong!',
                        false,
                      );
                      return;
                    }

                    Navigator.pop(context);

                    // Mengirimkan ID Kelas, bukan nama kelas teks lagi
                    final data = {
                      'name': name,
                      'email': emailController.text.trim(),
                      'classroom_id': selectedClassId,
                    };

                    if (!isEdit) data['password'] = 'password123';

                    Map<String, dynamic> response = isEdit
                        ? await AdminService.updateStudent(
                            studentItem['id'],
                            data,
                          )
                        : await AdminService.createStudent(data);

                    if (response['success'] == true ||
                        response['data'] != null) {
                      _showCustomSnackBar(
                        response['message'] ?? 'Data berhasil disimpan',
                        true,
                      );
                      _fetchData();
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
      },
    );
  }

  Future<void> _deleteStudent(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Siswa'),
        content: const Text('Yakin ingin menghapus data siswa ini?'),
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
      final response = await AdminService.deleteStudent(id);
      if (response['success'] == true) {
        _showCustomSnackBar('Data siswa berhasil dihapus', true);
        _fetchData();
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
          'Manage Students',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF093FB4),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF093FB4),
        onPressed: () => _showStudentDialog(),
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
                    onChanged: _filterStudents,
                    decoration: InputDecoration(
                      hintText: 'Cari nama siswa atau kelas...',
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
                  child: _filteredStudents.isEmpty
                      ? const Center(child: Text('Tidak ada data siswa.'))
                      : RefreshIndicator(
                          onRefresh: _fetchData,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: _filteredStudents.length,
                            itemBuilder: (context, index) {
                              final item = _filteredStudents[index];
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
                                            'Kelas: ${item['classroom']?['nama_kelas']?.toString() ?? '-'}',
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
                                          onPressed: () => _showStudentDialog(
                                            studentItem: item,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () =>
                                              _deleteStudent(item['id']),
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
