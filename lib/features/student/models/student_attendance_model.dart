class StudentAttendanceModel {
  final String id;
  final String subject;
  final String date;
  final String time;
  final String status;

  StudentAttendanceModel({
    required this.id,
    required this.subject,
    required this.date,
    required this.time,
    required this.status,
  });

  factory StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    final schedule = json['schedule'] ?? json['jadwal'] ?? {};
    final allocation =
        schedule['teacher_allocation'] ?? schedule['teacher_allocation'] ?? {};
    final subject = allocation['subject'] ?? allocation['mata_pelajaran'] ?? {};
    return StudentAttendanceModel(
      id: json['id']?.toString() ?? '',
      subject:
          subject['nama_mapel']?.toString() ??
          subject['name']?.toString() ??
          '-',
      date: json['date']?.toString() ?? json['tanggal']?.toString() ?? '-',
      time: schedule['time']?.toString() ?? schedule['jam']?.toString() ?? '-',
      status: json['status']?.toString() ?? '-',
    );
  }
}
