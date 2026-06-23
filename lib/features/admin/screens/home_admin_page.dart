import 'package:flutter/material.dart';
import 'package:mobile_sekolah/features/admin/screens/profile_page.dart';
import '../services/admin_service.dart';
import '../widgets/admin_bottom_navbar.dart';
import '../widgets/admin_stat_card.dart';
import '../widgets/admin_menu_card.dart';
import 'manage_students_page.dart';
import 'manage_teachers_page.dart';
import 'manage_classes_page.dart';
import 'attendance_report_page.dart';
import '../widgets/admin_report_card.dart';
import 'package:mobile_sekolah/shared/screens/notification_page.dart';
import 'package:mobile_sekolah/shared/widgets/custom_loading.dart';
import '../models/school_stat_model.dart';
import 'package:mobile_sekolah/services/storage_service.dart';
import 'package:mobile_sekolah/services/api_service.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int _selectedIndex = 0;
  late Future<Map<String, dynamic>> _dashboardFuture;
  late Future<List<Map<String, dynamic>>> _notificationsFuture;

  @override
  @override
  void initState() {
    super.initState();

    _dashboardFuture = AdminService.getDashboard();

    _notificationsFuture = AdminService.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF093FB4),
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: AdminBottomNavbar(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 1:
        return _buildManagePage();
      case 2:
        return const AttendanceReportPage();
      case 3:
        return const ProfilePage();
      case 0:
      default:
        return _buildHomeFuture();
    }
  }

  Widget _buildHomeFuture() {
    return FutureBuilder<Map<String, dynamic>>(
      future: _dashboardFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CustomLoading();
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Text(
              snapshot.error?.toString() ?? 'Gagal memuat data admin.',
            ),
          );
        }

        final result = snapshot.data!;
        if (result['success'] != true) {
          return Center(
            child: Text(result['message'] ?? 'Gagal memuat data admin.'),
          );
        }

        final dashboard = result['data'] as Map<String, dynamic>;
        final stats = <Map<String, dynamic>>[
          {
            'label': 'Siswa',
            'value': dashboard['jumlah_siswa'] ?? 0,
            'description': 'Total siswa aktif',
          },
          {
            'label': 'Guru',
            'value': dashboard['jumlah_guru'] ?? 0,
            'description': 'Total guru aktif',
          },
          {
            'label': 'Kelas',
            'value': dashboard['jumlah_kelas'] ?? 0,
            'description': 'Jumlah kelas',
          },
          {
            'label': 'Mapel',
            'value': dashboard['jumlah_mapel'] ?? 0,
            'description': 'Jumlah mata pelajaran',
          },
          {
            'label': 'User',
            'value': dashboard['jumlah_user'] ?? 0,
            'description': 'Total akun terdaftar',
          },
        ];

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
              const Text(
                'Lihat ringkasan sekolah dan kontrol data secara real-time.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: stats.map((item) {
                  return AdminStatCard(
                    stat: SchoolStatModel(
                      label: item['label'],
                      value: item['value'],
                      description: item['description'],
                    ),
                  );
                }).toList(),
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
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _notificationsFuture,

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 80,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Text('Gagal memuat notifikasi');
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Belum ada notifikasi');
                  }

                  final notifications = snapshot.data!;

                  return Column(
                    children: notifications.map((item) {
                      return AdminReportCard(
                        title: item['title'] ?? '',

                        subtitle: item['message'] ?? '',

                        value: item['date'] ?? '',
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
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

  Widget _buildProfilePage() {
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
          _detailRow('Name', 'Admin'),
          const SizedBox(height: 12),
          _detailRow('Email', 'admin@sekolah.com'),
          const SizedBox(height: 12),
          _detailRow('School', 'Sekolah Anda'),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                final token = await StorageService.getToken();
                if (token != null) {
                  await ApiService.logout(token);
                }
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                }
              },
            ),
          ),
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
