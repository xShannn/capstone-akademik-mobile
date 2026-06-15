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
}
