import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceCard extends StatelessWidget {
  final String className;
  final double attendanceRate;
  final VoidCallback onScan;
  // 1. TAMBAHKAN PARAMETER INI
  final bool hasAttendedToday; 

  const AttendanceCard({
    super.key,
    required this.className,
    required this.attendanceRate,
    required this.onScan,
    this.hasAttendedToday = false, // Nilai default-nya false (belum absen)
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    // Jika sudah absen, matikan fungsi tap agar tidak bisa scan lagi (opsional)
    return GestureDetector(
      onTap: hasAttendedToday ? null : onScan, 
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFF1950C9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ... (BAGIAN TEKS KIRI TETAP SAMA) ...
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Today, $formattedDate',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      className,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Attendance: ${attendanceRate.toInt()}%',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              
              // --- Bagian Lingkaran (Kanan) ---
              Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25), 
                    width: 3, 
                  ),
                  color: Colors.white.withOpacity(0.05),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 2. UBAH LOGIKA IKON DISINI
                    Icon(
                      hasAttendedToday ? Icons.check_circle : Icons.qr_code_scanner,
                      color: hasAttendedToday ? Colors.greenAccent : Colors.white,
                      size: 34,
                    ),
                    const SizedBox(height: 4),
                    // 3. UBAH LOGIKA TEKS DISINI
                    Text(
                      hasAttendedToday ? 'Hadir' : 'Presensi',
                      style: TextStyle(
                        color: hasAttendedToday ? Colors.greenAccent : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}