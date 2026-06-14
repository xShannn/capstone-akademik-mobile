import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  // Menangkap fungsi dari Main Page agar tombol Back bisa geser ke Home
  final Function(int)? onTabChange;

  // penerima data dan penerima fungsi
  final List<Map<String, dynamic>> tasks;
  final Function(Map<String, dynamic>) onToggleTask;

  const TaskPage({
    super.key,
    this.onTabChange,
    required this.tasks,
    required this.onToggleTask,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // State untuk filter tab yang sedang aktif
  String _activeFilter = 'All'; // Pilihannya: 'All', 'Pending', 'Done'

  @override
  Widget build(BuildContext context) {
    // Logika untuk menyaring daftar tugas sesuai tab yang diklik
    List<Map<String, dynamic>> filteredTasks = widget.tasks.where((task) {
      if (_activeFilter == 'Pending') return !task['isDone'];
      if (_activeFilter == 'Done') return task['isDone'];
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F42B3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Memanggil fungsi untuk geser kembali ke Home (Index 0)
            if (widget.onTabChange != null) {
              widget.onTabChange!(0);
            }
          },
        ),
        title: const Text(
          'Tasks',
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
          // --- BAGIAN TAB FILTER ---
          // --- BAGIAN TAB FILTER (Segmented Control Baru) ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildSegmentedFilter(
              options: ['All', 'Pending', 'Done'],
              activeOption: _activeFilter,
              onSelect: (value) {
                setState(() {
                  _activeFilter = value;
                });
              },
            ),
          ),
          const SizedBox(height: 16),

          // --- BAGIAN LIST TUGAS ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                return _buildTaskCard(task);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk tombol Tab Filter (All, Pending, Done)
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

  // Widget untuk Card Tugas
  Widget _buildTaskCard(Map<String, dynamic> task) {
    bool isDone = task['isDone'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task['title'],
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A24),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                task['teacher'],
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text('•', style: TextStyle(color: Colors.grey)),
              ),
              Text(
                'Due: ${task['due']}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            task['desc'],
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),

          // --- BAGIAN INI YANG DIUPDATE MENJADI BISA DIKLIK ---
          GestureDetector(
            onTap: () {
              widget.onToggleTask(task); // Memanggil perintah ke Induk
            },
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ), // Tambahan efek animasi perubahan warna
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isDone ? const Color(0xFFE6F4EA) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: isDone
                    ? Border.all(color: Colors.transparent)
                    : Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                isDone ? 'Selesai' : 'Tandai Selesai',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDone
                      ? const Color(0xFF15803D)
                      : Colors.grey.shade400,
                  fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
