import 'package:flutter/material.dart';
// Sesuaikan import di bawah dengan path project kamu
import 'package:mobile_sekolah/features/student/screens/home_student_page.dart'; // path home page
import 'package:mobile_sekolah/features/student/screens/grade_page.dart'; // path grade page
import 'package:mobile_sekolah/features/student/screens/task_page.dart'; // path task page
import 'package:mobile_sekolah/features/student/screens/profile_page.dart'; // path profile

class MainStudentPage extends StatefulWidget {
  const MainStudentPage({super.key});

  @override
  State<MainStudentPage> createState() => _MainStudentPageState();
}

class _MainStudentPageState extends State<MainStudentPage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  // --- 1. PINDAHKAN DATA GLOBAL KE SINI ---
  final List<Map<String, dynamic>> _globalTasks = [
    {
      'title': 'Tugas Fisika Bab 4',
      'teacher': 'Bu Rina',
      'due': '1 May',
      'desc': 'LKS Halaman 34',
      'isDone': true,
    },
    {
      'title': 'Essay B. Indonesia',
      'teacher': 'Bu Rina',
      'due': '1 May',
      'desc': 'Halaman 14',
      'isDone': false,
    },
    {
      'title': 'Laporan Praktikum Kimia',
      'teacher': 'Pak Budi',
      'due': '3 May',
      'desc': 'Bab Asam Basa',
      'isDone': false,
    },
    {
      'title': 'PR Matematika',
      'teacher': 'Bu Siti',
      'due': '5 May',
      'desc': 'Latihan Soal 2.1',
      'isDone': false,
    },
    {
      'title': 'Presentasi Sejarah',
      'teacher': 'Pak Anwar',
      'due': '10 May',
      'desc': 'PPT Kemerdekaan',
      'isDone': true,
    },
  ];

  // Fungsi untuk mengubah status tugas dari mana saja
  void _toggleTaskStatus(Map<String, dynamic> task) {
    setState(() {
      task['isDone'] = !task['isDone'];
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Kita berikan fungsi _onItemTapped ke halaman anak-anaknya
          // --- 2. KIRIM DATA KE ANAK-ANAKNYA ---
          HomeStudentPage(onTabChange: _onItemTapped, tasks: _globalTasks),
          GradePage(onTabChange: _onItemTapped),
          TaskPage(
            onTabChange: _onItemTapped,
            tasks: _globalTasks,
            onToggleTask: _toggleTaskStatus,
          ),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFFFFF),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0F42B3),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Grade',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: 'Task'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
