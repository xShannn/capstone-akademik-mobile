import 'package:flutter/material.dart';
import '../models/child_model.dart';
import '../services/parent_service.dart';

class ReportPage extends StatelessWidget {
  final ChildModel child;

  const ReportPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        backgroundColor: const Color(0xFF093FB4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${child.name} - ${child.studentClass}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            const Text(
              'Ringkasan nilai anak Anda',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: ParentService.getReport(child.id),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: Text('Data tidak ditemukan'));
                  }

                  final report = List<Map<String, dynamic>>.from(
                    snapshot.data!['data'] ?? [],
                  );

                  return ListView.builder(
                    itemCount: report.length,

                    itemBuilder: (context, index) {
                      final item = report[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),

                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text(item['subject']),

                            Text('${item['score']}'),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
