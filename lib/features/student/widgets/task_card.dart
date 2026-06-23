import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String teacher;
  final String deadline;
  final String description;
  final bool isDone;
  final VoidCallback onToggle;

  const TaskCard({
    super.key,
    required this.title,
    required this.teacher,
    required this.deadline,
    required this.description,
    required this.isDone,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text('Guru: $teacher', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            'Deadline: $deadline',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Text(description, style: const TextStyle(color: Colors.black87)),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onToggle,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDone
                    ? Colors.green
                    : const Color(0xFF0F42B3),
              ),
              child: Text(isDone ? 'Selesai' : 'Tandai Selesai'),
            ),
          ),
        ],
      ),
    );
  }
}
