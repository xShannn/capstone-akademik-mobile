import 'package:flutter/material.dart';

import 'package:mobile_sekolah/features/student/services/student_service.dart';

class RiwayatPresensiPage extends StatefulWidget {
  const RiwayatPresensiPage({super.key});

  @override
  State<RiwayatPresensiPage> createState() => _RiwayatPresensiPageState();
}

class _RiwayatPresensiPageState extends State<RiwayatPresensiPage> {
  bool isLoading = true;

  List<Map<String, dynamic>> histories = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    try {
      final result = await StudentService.getAttendanceHistory();

      setState(() {
        histories = result;
      });
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  Color getBgColor(String status) {
    switch (status) {
      case 'H':
        return const Color(0xFFDCFCE7);

      case 'A':
        return const Color(0xFFFEE2E2);

      case 'I':
        return const Color(0xFFFEF9C3);

      default:
        return Colors.grey.shade200;
    }
  }

  Color getTextColor(String status) {
    switch (status) {
      case 'H':
        return const Color(0xFF166534);

      case 'A':
        return const Color(0xFF991B1B);

      case 'I':
        return const Color(0xFF854D0E);

      default:
        return Colors.black87;
    }
  }

  String getStatus(String status) {
    switch (status) {
      case 'H':
        return 'Hadir';

      case 'A':
        return 'Absen';

      case 'I':
        return 'Izin';

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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Riwayat Presensi',
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : histories.isEmpty
          ? const Center(child: Text('Belum ada data presensi'))
          : ListView.builder(
              padding: const EdgeInsets.all(20),

              itemCount: histories.length,

              itemBuilder: (context, index) {
                final item = histories[index];

                final status = item['status']?.toString() ?? '-';

                final date = item['date']?.toString() ?? '-';

                final day = item['schedule']?['day']?.toString() ?? '-';

                final subject =
                    item['schedule']?['teacher_allocation']?['subject']?['nama_mapel']
                        ?.toString() ??
                    '-';

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),

                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: getBgColor(status),

                    borderRadius: BorderRadius.circular(18),
                  ),
                  // ... di dalam itemBuilder (bagian return Container) ...
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subject,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: getTextColor(status),
                            ),
                          ),
                          const SizedBox(height: 6), // Sedikit lebih lega
                          Text(
                            day,
                            style: TextStyle(
                              color: getTextColor(
                                status,
                              ).withOpacity(0.8), // Sedikit lebih transparan
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 10), // Jarak ke label status
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: getTextColor(
                                status,
                              ).withOpacity(0.1), // Efek background tipis
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              getStatus(status),
                              style: TextStyle(
                                color: getTextColor(status),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Tanggal ditaruh di pojok kanan atas
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          date,
                          style: TextStyle(
                            color: getTextColor(status).withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,

                  //       children: [
                  //         Text(
                  //           subject,

                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,

                  //             fontSize: 16,

                  //             color: getTextColor(status),
                  //           ),
                  //         ),

                  //         const SizedBox(height: 5),

                  //         Text(
                  //           day,

                  //           style: TextStyle(color: getTextColor(status)),
                  //         ),

                  //         const SizedBox(height: 5),

                  //         Text(
                  //           getStatus(status),

                  //           style: TextStyle(
                  //             color: getTextColor(status),

                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ],
                  //     ),

                  //     Text(
                  //       date,

                  //       style: TextStyle(
                  //         color: getTextColor(status),

                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                );
              },
            ),
    );
  }
}
