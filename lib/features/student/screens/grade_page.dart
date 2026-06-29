import 'package:flutter/material.dart';
import 'package:mobile_sekolah/features/student/models/student_grade_model.dart';
import 'package:mobile_sekolah/features/student/widgets/empty_state_widget.dart';
import 'package:mobile_sekolah/features/student/widgets/grade_card.dart';

class GradePage extends StatefulWidget {
  final Function(int)? onTabChange;
  final List<StudentGradeModel> grades;

  const GradePage({super.key, this.onTabChange, required this.grades});

  @override
  State<GradePage> createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  String _selectedSemester = 'Sem 1'; // Default filter

  List<StudentGradeModel> get _filteredGrades {
    if (_selectedSemester == 'All') return widget.grades;
    return widget.grades.where((g) => g.semester == _selectedSemester).toList();
  }

  double _averageScore() {
    final data = _filteredGrades;
    if (data.isEmpty) return 0;
    final total = data
        .map((g) => double.tryParse(g.score) ?? 0)
        .reduce((a, b) => a + b);
    return total / data.length;
  }

  // Logika sederhana untuk menentukan grade huruf dari rata-rata
  String _calculateOverallGrade(double average) {
    if (average >= 90) return 'A';
    if (average >= 85) return 'A-';
    if (average >= 80) return 'B+';
    if (average >= 75) return 'B';
    return 'C';
  }

  // Fungsi ranking dinamis
  String _getRankDisplay() {
    // Di sini kita gunakan data statis dulu karena ranking harusnya dari backend.
    // Tapi kita buat teksnya dinamis sesuai semester.
    return "#3 / 36 masih statis";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F42B3),
        elevation: 0,
        title: const Text('My Grades', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // --- FILTER SEGMENTED CONTROL ---
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: ['Sem 1', 'Sem 2', 'All'].map((sem) {
                  bool isSelected = _selectedSemester == sem;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedSemester = sem),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0F42B3)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          sem,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // --- RANKING CARD ---
          // --- RANKING CARD ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rank in Class ${_selectedSemester == 'All' ? '' : _selectedSemester}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _getRankDisplay(), // Panggil fungsi dinamis
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F42B3),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 30),
                  ..._filteredGrades.map(
                    (g) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(g.subject),
                          Row(
                            children: [
                              Text(
                                g.score,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F42B3),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  g.grade,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- GPA & OVERALL ---
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildInfoCard(
                  'GPA Average',
                  _averageScore().toStringAsFixed(1),
                ), // Sudah dinamis
                const SizedBox(width: 10),
                _buildInfoCard(
                  'Overall Grade',
                  _calculateOverallGrade(_averageScore()),
                ), // Sudah dinamis
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(title),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F42B3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
