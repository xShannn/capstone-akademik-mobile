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
    return Scaffold(
      appBar: AppBar(
        title: Text(classModel.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF093FB4),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: TeacherService.getStudentsByClass(classModel.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final students = snapshot.data ?? [];
          return SingleChildScrollView(
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
                if (students.isEmpty)
                  const Center(child: Text('Belum ada siswa dalam kelas ini.'))
                else
                  Column(
                    children: students.map((student) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: TeacherStudentCard(
                          name: student['name']?.toString() ?? '-',
                          nis: student['nis']?.toString() ?? '-',
                          score:
                              int.tryParse(
                                student['score']?.toString() ?? '',
                              ) ??
                              0,
                          attendance:
                              int.tryParse(
                                student['attendance']?.toString() ?? '',
                              ) ??
                              0,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => InputGradesClassPage(
                                  classModel: classModel,
                                  student: student,
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
          );
        },
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
