import 'package:flutter/material.dart';
import 'package:mobile_sekolah/features/student/models/student_attendance_model.dart';
import 'package:mobile_sekolah/features/student/models/student_dashboard_model.dart';
import 'package:mobile_sekolah/features/student/models/student_grade_model.dart';
import 'package:mobile_sekolah/features/student/models/student_schedule_model.dart';
import 'package:mobile_sekolah/features/student/models/student_task_model.dart';
import 'package:mobile_sekolah/features/student/screens/grade_page.dart';
import 'package:mobile_sekolah/features/student/screens/home_student_page.dart';
import 'package:mobile_sekolah/features/student/screens/profile_page.dart';
import 'package:mobile_sekolah/features/student/screens/task_page.dart';
import 'package:mobile_sekolah/features/student/services/student_service.dart';
import 'package:mobile_sekolah/shared/screens/notification_page.dart';

class MainStudentPage extends StatefulWidget {
  const MainStudentPage({super.key});

  @override
  State<MainStudentPage> createState() => _MainStudentPageState();
}

class _MainStudentPageState extends State<MainStudentPage> {
  int _selectedIndex = 0;
  late PageController _pageController;
  bool _isLoading = true;
  StudentDashboardModel? dashboard;
  List<StudentTaskModel> tasks = [];
  List<StudentGradeModel> grades = [];
  List<StudentScheduleModel> schedules = [];

  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final dashboardResult = await StudentService.getDashboard();
      final taskResult = await StudentService.getTaskList();
      final gradeResult = await StudentService.getGradeList();
      final scheduleResult = await StudentService.getScheduleList();

      setState(() {
        dashboard = StudentDashboardModel.fromJson(dashboardResult);
        tasks = taskResult.map(StudentTaskModel.fromJson).toList();
        grades = gradeResult.map(StudentGradeModel.fromJson).toList();
        schedules = scheduleResult.map(StudentScheduleModel.fromJson).toList();
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  final List<String> _titles = ['Dashboard', 'Nilai', 'Tugas', 'Profil'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void toggleTask(StudentTaskModel task) {
    setState(() {
      final index = tasks.indexWhere((item) => item.id == task.id);
      if (index != -1) {
        tasks[index] = StudentTaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          teacher: task.teacher,
          deadline: task.deadline,
          isDone: !task.isDone,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _isLoading || dashboard == null
          ? const Center(child: CircularProgressIndicator())
          : PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                HomeStudentPage(
                  onTabChange: onTabChange,
                  dashboard: dashboard!,
                  schedules: schedules,
                  tasks: tasks,
                ),
                GradePage(onTabChange: onTabChange, grades: grades),
                TaskPage(
                  onTabChange: onTabChange,
                  tasks: tasks,
                  onToggleTask: toggleTask,
                ),
                const ProfilePage(),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onTabChange,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0F42B3),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Nilai'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tugas'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
