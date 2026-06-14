import 'package:flutter/material.dart';

class GradePage extends StatefulWidget {
  // Menangkap fungsi dari Main Page
  final Function(int)? onTabChange;

  const GradePage({super.key, this.onTabChange});

  @override
  State<GradePage> createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  String _activeFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      // --- TOMBOL BACK DITAMBAHKAN KEMBALI DI SINI ---
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F42B3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Memanggil fungsi untuk geser ke Home (Index 0)
            if (widget.onTabChange != null) {
              widget.onTabChange!(0);
            }
          },
        ),
        title: const Text(
          'My Grades',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Bagian Filter Segmented Control
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildSegmentedFilter(
              options: ['Sem 1', 'Sem 2', 'All'],
              activeOption: _activeFilter,
              onSelect: (value) {
                setState(() {
                  _activeFilter = value;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  if (_activeFilter == 'Sem 1' || _activeFilter == 'All') ...[
                    _buildSemesterCard('Semester 1'),
                    const SizedBox(height: 16),
                    _buildSummaryCard(
                      'GPA Average',
                      '84',
                      const Color(0xFF0F42B3),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryCard('Overall Grade', 'A-', Colors.green),
                    const SizedBox(height: 24),
                  ],
                  if (_activeFilter == 'Sem 2' || _activeFilter == 'All') ...[
                    _buildSemesterCard('Semester 2'),
                    const SizedBox(height: 16),
                    _buildSummaryCard(
                      'GPA Average',
                      '84',
                      const Color(0xFF0F42B3),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryCard('Overall Grade', 'A-', Colors.green),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Custom untuk Segmented Filter (Desain Baru)
  Widget _buildSegmentedFilter({
    required List<String> options,
    required String activeOption,
    required Function(String) onSelect,
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.shade50,
          width: 2,
        ), // Outline/Border tipis
      ),
      child: Row(
        children: options.map((option) {
          bool isActive = activeOption == option;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: EdgeInsets.only(
                  right: option == options.last ? 0 : 4,
                ), // Jarak tipis antar tombol
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF0F42B3)
                      : const Color(
                          0xFFF3F6FB,
                        ), // Warna inactive abu-abu kebiruan
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    option,
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey.shade500,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSemesterCard(String semesterName) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rank in Class $semesterName',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A24),
                ),
              ),
              const Text(
                '#3 / 36',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF0F42B3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSubjectRow('Matematika', '88', 'A', Colors.green),
          const SizedBox(height: 16),
          _buildSubjectRow('Fisika', '75', 'B', Colors.blue),
          const SizedBox(height: 16),
          _buildSubjectRow('Bahasa Indonesia', '92', 'A+', Colors.green),
          const SizedBox(height: 16),
          _buildSubjectRow('Kimia', '88', 'B+', Colors.blue),
          const SizedBox(height: 16),
          _buildSubjectRow('Sejarah', '88', 'A', Colors.green),
        ],
      ),
    );
  }

  Widget _buildSubjectRow(
    String subject,
    String score,
    String grade,
    Color gradeColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              subject,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color(0xFF1A1A24),
              ),
            ),
          ),
          Text(
            score,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F42B3),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: gradeColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              grade,
              style: TextStyle(
                color: gradeColor,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Card GPA dan Overall Grade yang terlewat
  Widget _buildSummaryCard(String title, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Color(0xFF1A1A24), fontSize: 13),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
