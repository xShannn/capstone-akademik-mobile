import 'package:flutter/material.dart';
import '../models/attendance_model.dart';
import '../services/teacher_service.dart';

class AttendanceManualPage extends StatefulWidget {
  const AttendanceManualPage({super.key});

  @override
  State<AttendanceManualPage> createState() => _AttendanceManualPageState();
}

class _AttendanceManualPageState extends State<AttendanceManualPage> {
  late final List<AttendanceModel> attendance;

  @override
  void initState() {
    super.initState();
    attendance = TeacherService.getAttendanceList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual Attendance'),
        backgroundColor: const Color(0xFF093FB4),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: attendance.length,
        itemBuilder: (context, index) {
          final item = attendance[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFFEFF3FF),
                  child: Text(
                    item.studentName
                        .split(' ')
                        .map((e) => e.isNotEmpty ? e[0] : '')
                        .take(2)
                        .join(),
                    style: const TextStyle(
                      color: Color(0xFF093FB4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.studentName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'NIS ${item.nis}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.detail,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                _statusChip(item.status),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statusChip(AttendanceStatus status) {
    final color = status == AttendanceStatus.present
        ? const Color(0xFF0F9D58)
        : status == AttendanceStatus.late
        ? const Color(0xFFF4B400)
        : const Color(0xFFDB4437);
    final label = status == AttendanceStatus.present
        ? 'Hadir'
        : status == AttendanceStatus.late
        ? 'Terlambat'
        : 'Izin';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
