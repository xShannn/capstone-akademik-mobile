import 'package:flutter/material.dart';
import '../models/admin_model.dart';
import '../services/admin_service.dart';
import '../widgets/admin_bottom_navbar.dart';
import '../widgets/admin_stat_card.dart';
import '../widgets/admin_menu_card.dart';
import 'manage_students_page.dart';
import 'manage_teachers_page.dart';
import 'manage_classes_page.dart';
import 'attendance_report_page.dart';
import '../widgets/admin_report_card.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final admin = AdminService.getAdmin();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF093FB4),
        elevation: 0,
        title: const Text('Admin Dashboard'),
      ),
      body: _buildBody(admin),
      bottomNavigationBar: AdminBottomNavbar(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  Widget _buildBody(AdminModel admin) {
    switch (_selectedIndex) {
      case 1:
        return _buildManagePage();
      case 2:
        return const AttendanceReportPage();
      case 3:
        return _buildProfilePage(admin);
      case 0:
      default:
        return _buildHomePage(admin);
    }
  }

  Widget _buildHomePage(AdminModel admin) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back, Admin',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(admin.schoolName, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: admin.stats
                .map((stat) => AdminStatCard(stat: stat))
                .toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Quick Actions',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          AdminMenuCard(
            title: 'Manage Students',
            icon: Icons.school,
            color: const Color(0xFF093FB4),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ManageStudentsPage()),
            ),
          ),
          const SizedBox(height: 12),
          AdminMenuCard(
            title: 'Manage Teachers',
            icon: Icons.person,
            color: const Color(0xFF22C55E),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ManageTeachersPage()),
            ),
          ),
          const SizedBox(height: 12),
          AdminMenuCard(
            title: 'Manage Classes',
            icon: Icons.class_,
            color: const Color(0xFFFACC15),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ManageClassesPage()),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Latest Notifications',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ...AdminService.getNotifications().map(
            (item) => AdminReportCard(
              title: item['title'] ?? '',
              subtitle: item['message'] ?? '',
              value: item['date'] ?? '',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagePage() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Text(
            'Manage Data',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          AdminMenuCard(
            title: 'Manage Students',
            icon: Icons.school,
            color: const Color(0xFF093FB4),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ManageStudentsPage()),
            ),
          ),
          const SizedBox(height: 12),
          AdminMenuCard(
            title: 'Manage Teachers',
            icon: Icons.person,
            color: const Color(0xFF22C55E),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ManageTeachersPage()),
            ),
          ),
          const SizedBox(height: 12),
          AdminMenuCard(
            title: 'Manage Classes',
            icon: Icons.class_,
            color: const Color(0xFFFACC15),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ManageClassesPage()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePage(AdminModel admin) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          _detailRow('Name', admin.name),
          const SizedBox(height: 12),
          _detailRow('Email', admin.email),
          const SizedBox(height: 12),
          _detailRow('School', admin.schoolName),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
