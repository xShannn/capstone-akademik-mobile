import 'package:flutter/material.dart';
import '../services/admin_service.dart';

class ManageStudentsPage extends StatelessWidget {
  const ManageStudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final students = AdminService.getStudents();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Students'),
        backgroundColor: const Color(0xFF093FB4),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final item = students[index];
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['class'] ?? '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  item['status'] ?? '',
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
