import 'package:flutter/material.dart';

class AttendanceGenerateQrPage extends StatelessWidget {
  const AttendanceGenerateQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance QR'),
        backgroundColor: const Color(0xFF093FB4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scan QR code to record attendance',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF3FF),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner,
                    color: Color(0xFF093FB4),
                    size: 80,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AttendanceGenerateQrPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF093FB4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minimumSize: const Size.fromHeight(52),
              ),
              child: const Text('Generate Attendance QR'),
            ),
          ],
        ),
      ),
    );
  }
}
