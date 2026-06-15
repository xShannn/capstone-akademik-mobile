import 'package:flutter/material.dart';
import '../models/teacher_class_model.dart';
import '../models/teacher_schedule_model.dart';
import '../services/teacher_service.dart';
import '../widgets/teacher_bottom_navbar.dart';
import '../widgets/teacher_class_card.dart';
import '../widgets/teacher_schedule_card.dart';
import 'attendance_manual_page.dart';
import 'class_page.dart';
import '../models/attendance_model.dart';

class HomeTeacherPage extends StatefulWidget {
  const HomeTeacherPage({super.key});

  @override
  State<HomeTeacherPage> createState() => _HomeTeacherPageState();
}

class _HomeTeacherPageState extends State<HomeTeacherPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final classes = TeacherService.getTeacherClasses();
    final schedule = TeacherService.getTeacherSchedule();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF093FB4),
        elevation: 0,
        title: const Text('Teacher Dashboard'),
      ),
      body: _buildBody(classes, schedule),
      bottomNavigationBar: TeacherBottomNavbar(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  Widget _buildBody(
    List<TeacherClassModel> classes,
    List<TeacherScheduleModel> schedule,
  ) {
    switch (_selectedIndex) {
      case 1:
        return _buildClassList(classes);
      case 2:
        return _buildScheduleView(schedule);
      case 3:
        return _buildAttendanceContent();
      case 0:
      default:
        return _buildDashboard(classes, schedule);
    }
  }

  Widget _buildAttendanceContent() {
    final attendance = TeacherService.getAttendanceList();
    return ListView.builder(
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
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
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

  Widget _buildDashboard(
    List<TeacherClassModel> classes,
    List<TeacherScheduleModel> schedule,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back, Pak Guru',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Lihat jadwal, kelas, dan data absensi hari ini.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          const Text(
            'My Classes',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: classes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = classes[index];
                return SizedBox(
                  width: 260,
                  child: TeacherClassCard(
                    item: item,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ClassPage(classModel: item),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Today Schedule',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Column(
            children: schedule
                .map((item) => TeacherScheduleCard(item: item))
                .toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _navigationCard(
                context,
                title: 'Attendance',
                icon: Icons.qr_code,
                target: const AttendanceManualPage(),
              ),
              const SizedBox(width: 12),
              _navigationCard(
                context,
                title: 'Input Grades',
                icon: Icons.grade,
                target: ClassPage(classModel: classes.first),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClassList(List<TeacherClassModel> classes) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: classes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = classes[index];
        return TeacherClassCard(
          item: item,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ClassPage(classModel: item)),
            );
          },
        );
      },
    );
  }

  Widget _buildScheduleView(List<TeacherScheduleModel> schedule) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Schedule',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: schedule.length,
              itemBuilder: (context, index) {
                return TeacherScheduleCard(item: schedule[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _navigationCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget target,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => target));
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, size: 28, color: const Color(0xFF093FB4)),
              const SizedBox(height: 12),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
