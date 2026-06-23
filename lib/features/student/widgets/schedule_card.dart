import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final String day;
  final String time;
  final String subject;
  final String teacher;

  const ScheduleCard({
    super.key,
    required this.day,
    required this.time,
    required this.subject,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subject,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text('$day • $time', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(teacher, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
