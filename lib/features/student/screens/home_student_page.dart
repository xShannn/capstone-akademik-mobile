import 'package:flutter/material.dart';
import 'package:mobile_sekolah/features/student/models/student_dashboard_model.dart';
import 'package:mobile_sekolah/features/student/models/student_schedule_model.dart';
import 'package:mobile_sekolah/features/student/models/student_task_model.dart';
import 'package:mobile_sekolah/features/student/screens/presensi_page.dart';
import 'package:mobile_sekolah/features/student/widgets/attendance_card.dart';
import 'package:mobile_sekolah/features/student/widgets/dashboard_card.dart';
import 'package:mobile_sekolah/features/student/widgets/empty_state_widget.dart';
import 'package:mobile_sekolah/features/student/widgets/schedule_card.dart';
import 'package:mobile_sekolah/features/student/widgets/task_card.dart';

class HomeStudentPage extends StatelessWidget {
  final Function(int)? onTabChange;
  final StudentDashboardModel dashboard;
  final List<StudentScheduleModel> schedules;
  final List<StudentTaskModel> tasks;

  const HomeStudentPage({
    super.key,
    this.onTabChange,
    required this.dashboard,
    required this.schedules,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  AttendanceCard(
                    className: dashboard.className,
                    attendanceRate: dashboard.attendanceRate,
                    onScan: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PresensiPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  DashboardCard(
                    title: 'Rata-rata Nilai',
                    value: dashboard.averageScore.toStringAsFixed(1),
                    subtitle: 'Jumlah tugas: ${dashboard.taskCount}',
                    color: const Color(0xFF0F42B3),
                  ),
                  const SizedBox(height: 20),
                  _sectionHeader(
                    context,
                    title: 'Upcoming Tasks',
                    onTap: () => onTabChange?.call(2),
                  ),
                  const SizedBox(height: 12),
                  if (tasks.isEmpty)
                    const EmptyStateWidget(message: 'Belum ada tugas')
                  else
                    Column(
                      children: tasks
                          .take(3)
                          .map(
                            (task) => TaskCard(
                              title: task.title,
                              teacher: task.teacher,
                              deadline: task.deadline,
                              description: task.description,
                              isDone: task.isDone,
                              onToggle: () => onTabChange?.call(2),
                            ),
                          )
                          .toList(),
                    ),
                  const SizedBox(height: 20),
                  _sectionHeader(
                    context,
                    title: 'Jadwal Hari Ini',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  if (schedules.isEmpty)
                    const EmptyStateWidget(message: 'Belum ada jadwal')
                  else
                    Column(
                      children: schedules
                          .map(
                            (schedule) => ScheduleCard(
                              day: schedule.day,
                              time: schedule.time,
                              subject: schedule.subject,
                              teacher: schedule.teacher,
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(color: Color(0xFF0F42B3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Good Morning',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            dashboard.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            dashboard.className,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ],
    );
  }
}
