import 'package:flutter/material.dart';
import '../models/teacher_class_model.dart';
import '../services/teacher_service.dart';
import 'input_grades_student_page.dart';

class InputGradesClassPage extends StatefulWidget {
  final TeacherClassModel classModel;
  final Map<String, dynamic> student;

  const InputGradesClassPage({
    super.key,
    required this.classModel,
    required this.student,
  });

  @override
  State<InputGradesClassPage> createState() => _InputGradesClassPageState();
}

class _InputGradesClassPageState extends State<InputGradesClassPage> {
  final _uh1Controller = TextEditingController();
  final _uh2Controller = TextEditingController();
  final _utsController = TextEditingController();
  final _uasController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitGrades() async {
    setState(() {
      _isLoading = true;
    });

    final data = {
      'class_id': widget.classModel.id,
      'student_id': widget.student['id'],
      'uh1': _uh1Controller.text.trim(),
      'uh2': _uh2Controller.text.trim(),
      'uts': _utsController.text.trim(),
      'uas': _uasController.text.trim(),
    };

    final response = await TeacherService.saveGrade(data);

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    if (response['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Berhasil menyimpan nilai')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => InputGradesStudentPage(
            classModel: widget.classModel,
            studentName: widget.student['name']?.toString() ?? '-',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Gagal menyimpan nilai')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentName = widget.student['name']?.toString() ?? '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Grades', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF093FB4),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kelas: ${widget.classModel.name}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Siswa: $studentName',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildInputField('UH 1', _uh1Controller),
            const SizedBox(height: 16),
            _buildInputField('UH 2', _uh2Controller),
            const SizedBox(height: 16),
            _buildInputField('UTS', _utsController),
            const SizedBox(height: 16),
            _buildInputField('UAS', _uasController),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitGrades,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF093FB4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Simpan Nilai & Lanjut', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF5F7FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
