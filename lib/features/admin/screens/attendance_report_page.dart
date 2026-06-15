import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../widgets/admin_report_card.dart';

class AttendanceReportPage extends StatelessWidget {
  const AttendanceReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = AdminService.getAttendanceReport();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        title: const Text('Attendance Report'),
        backgroundColor: const Color(0xFF093FB4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: reports.map((report) {
            return AdminReportCard(
              title: report['date'] ?? '',
              subtitle: 'Kehadiran ${report['present']}',
              value: report['notes'] ?? '',
            );
          }).toList(),
        ),
      ),
    );
  }
}
