import 'package:flutter/material.dart';
import '../models/teacher_class_model.dart';
import 'input_grades_student_page.dart';

class InputGradesClassPage extends StatelessWidget {
  final TeacherClassModel classModel;
  final String studentName;

  const InputGradesClassPage({
    super.key,
    required this.classModel,
    required this.studentName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Grades'),
        backgroundColor: const Color(0xFF093FB4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kelas: ${classModel.name}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Siswa: $studentName',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildInputField(context, 'UH 1'),
            const SizedBox(height: 16),
            _buildInputField(context, 'UH 2'),
            const SizedBox(height: 16),
            _buildInputField(context, 'UTS'),
            const SizedBox(height: 16),
            _buildInputField(context, 'UAS'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InputGradesStudentPage(
                        classModel: classModel,
                        studentName: studentName,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF093FB4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context, String label) {
    return TextField(
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
