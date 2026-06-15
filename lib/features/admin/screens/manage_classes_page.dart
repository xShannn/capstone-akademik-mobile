import 'package:flutter/material.dart';
import '../services/admin_service.dart';

class ManageClassesPage extends StatelessWidget {
  const ManageClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final classes = AdminService.getClasses();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Classes'),
        backgroundColor: const Color(0xFF093FB4),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final item = classes[index];
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
                      item['room'] ?? '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  '${item['students']}',
                  style: const TextStyle(
                    color: Color(0xFF093FB4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
