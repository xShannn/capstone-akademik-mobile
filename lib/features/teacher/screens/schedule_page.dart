import 'package:flutter/material.dart';
import '../models/teacher_schedule_model.dart';
import '../services/teacher_service.dart';
import '../widgets/teacher_schedule_card.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late Future<List<TeacherScheduleModel>> _scheduleFuture;

  @override
  void initState() {
    super.initState();
    _fetchSchedule();
  }

  void _fetchSchedule() {
    setState(() {
      _scheduleFuture = TeacherService.getTeacherSchedule();
    });
  }

  Future<void> _showScheduleDialog({TeacherScheduleModel? scheduleItem}) async {
    final bool isEdit = scheduleItem != null;
    final TextEditingController dayController =
        TextEditingController(text: isEdit ? scheduleItem.day : '');
    final TextEditingController timeController =
        TextEditingController(text: isEdit ? scheduleItem.time : '');
    final TextEditingController subjectController =
        TextEditingController(text: isEdit ? scheduleItem.subject : '');
    final TextEditingController roomController =
        TextEditingController(text: isEdit ? scheduleItem.room : '');
    final TextEditingController classController =
        TextEditingController(text: isEdit ? scheduleItem.className : '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Jadwal' : 'Tambah Jadwal'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: dayController,
                  decoration: const InputDecoration(labelText: 'Hari', hintText: 'Contoh: Senin'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(labelText: 'Jam', hintText: 'Contoh: 08:00 - 09:30'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: subjectController,
                  decoration: const InputDecoration(labelText: 'Mata Pelajaran', hintText: 'Contoh: Matematika'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: roomController,
                  decoration: const InputDecoration(labelText: 'Ruangan', hintText: 'Contoh: R-101'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: classController,
                  decoration: const InputDecoration(labelText: 'Kelas', hintText: 'Contoh: 10 IPA 1'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final data = {
                  'day': dayController.text.trim(),
                  'time': timeController.text.trim(),
                  'subject': subjectController.text.trim(),
                  'room': roomController.text.trim(),
                  'class_name': classController.text.trim(),
                };

                if (data['day']!.isEmpty || data['time']!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Hari dan jam tidak boleh kosong')),
                  );
                  return;
                }

                Navigator.pop(context, true);

                Map<String, dynamic> response;
                if (isEdit) {
                  response = await TeacherService.updateSchedule(scheduleItem.id, data);
                } else {
                  response = await TeacherService.createSchedule(data);
                }

                if (!mounted) return;

                if (response['success']) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response['message'] ?? 'Berhasil menyimpan jadwal')),
                  );
                  _fetchSchedule();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response['message'] ?? 'Gagal menyimpan jadwal')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF093FB4),
                foregroundColor: Colors.white,
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteSchedule(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Jadwal'),
          content: const Text('Apakah Anda yakin ingin menghapus jadwal ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      final response = await TeacherService.deleteSchedule(id);
      if (!mounted) return;

      if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Berhasil menghapus jadwal')),
        );
        _fetchSchedule();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Gagal menghapus jadwal')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF093FB4),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF093FB4),
        onPressed: () => _showScheduleDialog(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: FutureBuilder<List<TeacherScheduleModel>>(
        future: _scheduleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final schedule = snapshot.data ?? [];
          if (schedule.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                _fetchSchedule();
                await _scheduleFuture;
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 100),
                  Center(child: Text('Jadwal belum tersedia.')),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              _fetchSchedule();
              await _scheduleFuture;
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Weekly Schedule',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: schedule.length,
                      itemBuilder: (context, index) {
                        final item = schedule[index];
                        return TeacherScheduleCard(
                          item: item,
                          onEdit: () => _showScheduleDialog(scheduleItem: item),
                          onDelete: item.id.isNotEmpty ? () => _deleteSchedule(item.id) : null,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
