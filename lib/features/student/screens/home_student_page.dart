import 'package:flutter/material.dart';
import 'package:mobile_sekolah/features/student/models/student_dashboard_model.dart';
import 'package:mobile_sekolah/features/student/models/student_schedule_model.dart';
import 'package:mobile_sekolah/features/student/models/student_task_model.dart';
import 'package:mobile_sekolah/features/student/screens/presensi_page.dart';
import 'package:mobile_sekolah/features/student/widgets/attendance_card.dart';
import 'package:mobile_sekolah/features/student/widgets/dashboard_card.dart';
import 'package:mobile_sekolah/features/student/widgets/empty_state_widget.dart';
import 'package:mobile_sekolah/features/student/widgets/schedule_card.dart';
import 'package:mobile_sekolah/shared/screens/notification_page.dart';

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

  String _getInitials(String name) {
    if (name.isEmpty) return "AK";
    List<String> nameParts = name.trim().split(RegExp(r'\s+'));
    if (nameParts.length > 1) {
      return (nameParts[0][0] + nameParts[1][0]).toUpperCase();
    }
    return nameParts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(context),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  AttendanceCard(
                    className: dashboard.className,
                    attendanceRate: dashboard.attendanceRate,
                    hasAttendedToday: false, // Ubah jadi true kalau sudah presensi
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
                  
                  // --- BAGIAN TUGAS YANG BARU ---
                  _buildUpcomingTasksCard(),
                  
                  const SizedBox(height: 24),
                  
                  // --- BAGIAN JADWAL ---
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
                      children: schedules.asMap().entries.map((entry) {
                        int index = entry.key + 1;
                        var schedule = entry.value;
                        return ScheduleCard(
                          index: index,
                          day: schedule.day,
                          time: schedule.time,
                          subject: schedule.subject,
                          teacher: schedule.teacher,
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Desain baru untuk membungkus list tugas di dalam satu kartu
  Widget _buildUpcomingTasksCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Tasks
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upcoming Tasks',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B), // Warna teks gelap
                ),
              ),
              // Tombol panah yang mengarah ke tab Tugas
              GestureDetector(
                onTap: () => onTabChange?.call(2),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // List Tugas
          if (tasks.isEmpty)
            const EmptyStateWidget(message: 'Belum ada tugas')
          else
            Column(
              children: tasks.take(3).map((task) => _buildMinimalTaskItem(task)).toList(),
            ),
        ],
      ),
    );
  }

  // Desain item tugas yang minimalis (kotak centang + judul + status)
  Widget _buildMinimalTaskItem(StudentTaskModel task) {
    final isDone = task.isDone;
    // Menentukan warna berdasarkan status (Hijau = Selesai, Biru = Belum Selesai)
    final color = isDone ? const Color(0xFF22C55E) : const Color(0xFF3B82F6);
    final bgColor = isDone ? const Color(0xFFDCFCE7) : const Color(0xFFEFF6FF);
    final statusText = isDone ? 'Selesai' : 'Belum Selesai';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          // Ikon kotak bergaya checkbox
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color, width: 1.5),
            ),
          ),
          const SizedBox(width: 12),
          // Judul Tugas
          Expanded(
            child: Text(
              task.title,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF333333),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Status Tugas
          Text(
            statusText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF0F42B3),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good morning,',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                dashboard.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 24,
                      ),
                      Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getInitials(dashboard.name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
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