import 'package:flutter/material.dart';
import '../models/teacher_class_model.dart';
import '../services/teacher_service.dart';
import '../widgets/teacher_student_card.dart';
import 'input_grades_class_page.dart';

class ClassPage extends StatelessWidget {
  final TeacherClassModel classModel;

  const ClassPage({super.key, required this.classModel});

  @override
  Widget build(BuildContext context) {
    final students = TeacherService.getStudentsByClass(classModel.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(classModel.name),
        backgroundColor: const Color(0xFF093FB4),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoCard('Subject', classModel.subject),
            const SizedBox(height: 12),
            _infoCard('Room', classModel.room),
            const SizedBox(height: 12),
            _infoCard('Students', '${classModel.studentCount} siswa'),
            const SizedBox(height: 20),
            const Text(
              'Students',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Column(
              children: students.map((student) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TeacherStudentCard(
                    name: student['name'],
                    nis: student['nis'],
                    score: student['score'],
                    attendance: student['attendance'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InputGradesClassPage(
                            classModel: classModel,
                            studentName: student['name'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
