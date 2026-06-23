import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  final String className;
  final double attendanceRate;
  final VoidCallback onScan;

  const AttendanceCard({
    super.key,
    required this.className,
    required this.attendanceRate,
    required this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onScan,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF0F42B3), Color(0xFF2E65E5)],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  className,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Presensi: ${attendanceRate.toStringAsFixed(0)}%',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
            const Icon(Icons.qr_code_scanner, color: Colors.white, size: 60),
          ],
        ),
      ),
    );
  }
}
