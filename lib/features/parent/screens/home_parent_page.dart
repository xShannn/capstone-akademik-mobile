import 'package:flutter/material.dart';
import '../models/child_model.dart';
import '../models/parent_model.dart';
import '../services/parent_service.dart';
import '../widgets/parent_child_card.dart';
import '../widgets/parent_stat_card.dart';
import '../widgets/parent_bottom_navbar.dart';
import 'child_profile_page.dart';
import 'package:mobile_sekolah/shared/screens/notification_page.dart';
import 'package:mobile_sekolah/services/storage_service.dart';
import 'package:mobile_sekolah/services/api_service.dart';

class HomeParentPage extends StatefulWidget {
  const HomeParentPage({super.key});

  @override
  State<HomeParentPage> createState() => _HomeParentPageState();
}

class _HomeParentPageState extends State<HomeParentPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF093FB4),
        title: const Text('Parent Dashboard'),
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

      body: FutureBuilder<ParentModel?>(
        future: ParentService.getParent(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Data parent tidak ditemukan'));
          }

          final parent = snapshot.data!;
          final children = parent.children;

          return _buildBody(parent, children);
        },
      ),

      bottomNavigationBar: ParentBottomNavbar(
        selectedIndex: _selectedIndex,

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildBody(ParentModel parent, List<ChildModel> children) {
    switch (_selectedIndex) {
      case 1:
        return _buildChildPage(children);
      case 2:
        return const NotificationPage();
      case 3:
        return _buildProfilePage(parent);
      case 0:
      default:
        return _buildHomePage(parent, children);
    }
  }

  Widget _buildHomePage(ParentModel parent, List<ChildModel> children) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, ${parent.name}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Lihat ringkasan nilai dan presensi anak Anda.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ParentStatCard(
                label: 'Anak',
                value: '${parent.children.length}',
                color: const Color(0xFF093FB4),
              ),
              ParentStatCard(
                label: 'Rata-rata Nilai',

                value: children.isEmpty
                    ? '0'
                    : (children
                                  .map((e) => e.averageScore)
                                  .reduce((a, b) => a + b) /
                              children.length)
                          .toStringAsFixed(1),

                color: const Color(0xFF22C55E),
              ),
              ParentStatCard(
                label: 'Presensi',

                value: children.isEmpty
                    ? '0%'
                    : '${(children.map((e) => e.attendanceRate).reduce((a, b) => a + b) / children.length).toStringAsFixed(0)}%',

                color: const Color(0xFFFACC15),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Anak Anda',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Column(
            children: children.map((child) {
              return ParentChildCard(
                child: child,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChildProfilePage(child: child),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChildPage(List<ChildModel> children) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Text(
            'Child Summary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          ...children.map((child) {
            return ParentChildCard(
              child: child,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChildProfilePage(child: child),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProfilePage(ParentModel parent) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _infoRow('Nama', parent.name),
          const SizedBox(height: 12),
          _infoRow('Email', parent.email),
          const SizedBox(height: 12),
          _infoRow('Phone', parent.phone),
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

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
