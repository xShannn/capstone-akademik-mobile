class StudentScheduleModel {
  final String id;
  final String day;
  final String time;
  final String subject;
  final String teacher;

  StudentScheduleModel({
    required this.id,
    required this.day,
    required this.time,
    required this.subject,
    required this.teacher,
  });

  factory StudentScheduleModel.fromJson(Map<String, dynamic> json) {
    final subject = json['subject'] ?? json['mata_pelajaran'] ?? {};
    final teacher = json['teacher'] ?? json['guru'] ?? {};
    return StudentScheduleModel(
      id: json['id']?.toString() ?? '',
      day: json['day']?.toString() ?? json['hari']?.toString() ?? '-',
      time: json['time']?.toString() ?? json['jam']?.toString() ?? '-',
      subject:
          subject['nama_mapel']?.toString() ??
          subject['name']?.toString() ??
          '-',
      teacher:
          teacher['nama_lengkap']?.toString() ??
          teacher['name']?.toString() ??
          '-',
    );
  }
}
