import 'package:flutter/material.dart';
import '../models/child_model.dart';
import '../services/parent_service.dart';

class AttendancePage extends StatelessWidget {
  final ChildModel child;

  const AttendancePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final attendance = ParentService.getAttendance(child.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: const Color(0xFF093FB4),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: attendance.length,
        itemBuilder: (context, index) {
          final item = attendance[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['date'] ?? '',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  item['status'] ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
