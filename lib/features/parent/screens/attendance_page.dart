import 'package:flutter/material.dart';

import '../models/child_model.dart';
import '../services/parent_service.dart';

class AttendancePage extends StatelessWidget {
  final ChildModel child;

  const AttendancePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: const Color(0xFF093FB4),
      ),

      body: FutureBuilder<Map<String, dynamic>>(
        future: ParentService.getAttendance(child.id),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Data kosong'));
          }

          final response = snapshot.data!;

          if (response['success'] != true) {
            return Center(
              child: Text(response['message'] ?? 'Gagal mengambil data'),
            );
          }

          final attendance = List<Map<String, dynamic>>.from(
            response['data'] ?? [],
          );

          return ListView.builder(
            padding: const EdgeInsets.all(20),

            itemCount: attendance.length,

            itemBuilder: (context, index) {
              final item = attendance[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(item['date'] ?? ''),

                    Text(item['status'] ?? ''),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
