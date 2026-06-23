import 'package:flutter/material.dart';
import '../models/child_model.dart';
import '../services/parent_service.dart';
import '../widgets/parent_schedule_card.dart';

class SchedulePage extends StatelessWidget {
  final ChildModel child;

  const SchedulePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        backgroundColor: const Color(0xFF093FB4),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ParentService.getSchedule(child.id),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Data tidak ditemukan'));
          }

          final schedule = List<Map<String, dynamic>>.from(
            snapshot.data!['data'] ?? [],
          );

          return Padding(
            padding: const EdgeInsets.all(20),

            child: ListView(
              children: [
                Text(
                  '${child.name} - ${child.studentClass}',

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,

                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Jadwal pelajaran anak',

                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 20),

                ...schedule.map(
                  (item) => ParentScheduleCard(
                    day: item['day'] ?? '',

                    time: item['time'] ?? '',

                    subject: item['subject'] ?? '',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
