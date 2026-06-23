import 'package:flutter/material.dart';

import 'package:mobile_sekolah/features/student/screens/camera_scan_page.dart';

import 'package:mobile_sekolah/features/student/screens/riwayat_presensi_page.dart';

import 'package:mobile_sekolah/features/student/services/student_service.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  bool isLoading = true;

  String status = 'Belum';

  String tanggal = '-';

  @override
  void initState() {
    super.initState();

    loadAttendance();
  }

  Future<void> loadAttendance() async {
    try {
      final history = await StudentService.getAttendanceHistory();

      if (history.isNotEmpty) {
        final latest = history.first;

        setState(() {
          status = latest['status'] ?? 'Belum';

          tanggal = latest['date'] ?? '-';
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  Color getStatusColor() {
    switch (status) {
      case 'H':
        return Colors.green;

      case 'I':
        return Colors.orange;

      case 'A':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  String getStatusText() {
    switch (status) {
      case 'H':
        return 'Hadir';

      case 'I':
        return 'Izin';

      case 'A':
        return 'Absen';

      default:
        return 'Belum';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F42B3),

        title: const Text('Presensi'),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                children: [
                  const SizedBox(height: 40),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) => const CameraScanPage(),
                        ),
                      );
                    },

                    child: Container(
                      width: 180,

                      height: 180,

                      decoration: BoxDecoration(
                        color: const Color(0xFF2E65E5),

                        shape: BoxShape.circle,
                      ),

                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(
                            Icons.qr_code_scanner,

                            size: 70,

                            color: Colors.white,
                          ),

                          SizedBox(height: 10),

                          Text(
                            'Scan',

                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 18,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Text(tanggal),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,

                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: getStatusColor(),

                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      getStatusText(),

                      style: const TextStyle(
                        color: Colors.white,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  SizedBox(
                    width: double.infinity,

                    height: 55,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) => const RiwayatPresensiPage(),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F42B3),
                      ),

                      child: const Text('Lihat Riwayat Presensi'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
