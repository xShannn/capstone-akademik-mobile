import 'package:flutter/material.dart';

class GradeCard extends StatelessWidget {
  final String subject;
  final String score;
  final String grade;
  final String type;

  const GradeCard({
    super.key,
    required this.subject,
    required this.score,
    required this.grade,
    required this.type,
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
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF0F42B3),
            child: Text(score, style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(type, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              grade,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F42B3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
