import 'package:flutter/material.dart';
import 'package:mobile_sekolah/features/student/models/student_grade_model.dart';
import 'package:mobile_sekolah/features/student/widgets/empty_state_widget.dart';
import 'package:mobile_sekolah/features/student/widgets/grade_card.dart';

class GradePage extends StatelessWidget {
  final Function(int)? onTabChange;
  final List<StudentGradeModel> grades;

  const GradePage({super.key, this.onTabChange, required this.grades});

  double _averageScore() {
    if (grades.isEmpty) return 0;
    final total = grades
        .map((grade) => double.tryParse(grade.score) ?? 0)
        .reduce((a, b) => a + b);
    return total / grades.length;
  }

  @override
  Widget build(BuildContext context) {
    final average = _averageScore();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F42B3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            onTabChange?.call(0);
          },
        ),
        title: const Text('My Grades', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  const Text('Rata-rata Nilai', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text(
                    average.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F42B3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: grades.isEmpty
                  ? const EmptyStateWidget(message: 'Belum ada data nilai')
                  : ListView.builder(
                      itemCount: grades.length,
                      itemBuilder: (context, index) {
                        final grade = grades[index];
                        return GradeCard(
                          subject: grade.subject,
                          score: grade.score,
                          grade: grade.grade,
                          type: grade.type,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
