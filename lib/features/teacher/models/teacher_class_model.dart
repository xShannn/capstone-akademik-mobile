class TeacherClassModel {
  final String id;
  final String name;
  final String subject;
  final int studentCount;
  final double attendanceRate;
  final String room;

  const TeacherClassModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.studentCount,
    required this.attendanceRate,
    required this.room,
  });

  factory TeacherClassModel.fromJson(Map<String, dynamic> json) {
    return TeacherClassModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      studentCount:
          int.tryParse(json['student_count']?.toString() ?? '') ??
          int.tryParse(json['students']?.toString() ?? '') ??
          0,
      attendanceRate:
          double.tryParse(json['attendance_rate']?.toString() ?? '') ??
          double.tryParse(json['attendance']?.toString() ?? '') ??
          0,
      room: json['room']?.toString() ?? json['classroom']?.toString() ?? '',
    );
  }
}
