import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:mobile_sekolah/features/student/services/student_service.dart';

class CameraScanPage extends StatefulWidget {
  const CameraScanPage({super.key});

  @override
  State<CameraScanPage> createState() => _CameraScanPageState();
}

class _CameraScanPageState extends State<CameraScanPage> {
  bool isScanned = false;

  bool isLoading = false;

  Future<void> submitQR(String qrData) async {
    try {
      setState(() {
        isLoading = true;
      });

      final data = qrData.split('|');

      final scheduleId = int.parse(data[0]);

      final teacherAllocationId = int.parse(data[1]);

      final result = await StudentService.submitAttendance(
        scheduleId: scheduleId,

        teacherAllocationId: teacherAllocationId,
      );

      if (!mounted) return;

      if (result['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Presensi berhasil'),

            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'].toString()),

            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F42B3),

        title: const Text('Scan QR'),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),

                      child: MobileScanner(
                        onDetect: (capture) {
                          if (isScanned) {
                            return;
                          }

                          final barcode = capture.barcodes.first;

                          final code = barcode.rawValue;

                          if (code == null) {
                            return;
                          }

                          isScanned = true;

                          submitQR(code);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,

                    height: 55,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F42B3),
                      ),

                      child: const Text('Kembali'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
