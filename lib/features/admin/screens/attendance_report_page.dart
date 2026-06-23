import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../widgets/admin_report_card.dart';

class AttendanceReportPage extends StatelessWidget {
  const AttendanceReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        title: const Text('Attendance Report'),
        backgroundColor: const Color(0xFF093FB4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: AdminService.getAttendanceReport(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final reports = snapshot.data ?? [];
            if (reports.isEmpty) {
              return const Center(child: Text('Belum ada laporan presensi.'));
            }

            return ListView(
              children: reports.map((report) {
                return AdminReportCard(
                  title: report['date']?.toString() ?? '',
                  subtitle: 'Kehadiran ${report['present']?.toString() ?? '-'}',
                  value:
                      report['notes']?.toString() ??
                      report['remarks']?.toString() ??
                      '',
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
