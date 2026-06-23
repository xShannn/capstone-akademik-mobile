class TeacherScheduleModel {
  final String id;
  final String day;
  final String time;
  final String subject;
  final String room;
  final String className;

  const TeacherScheduleModel({
    required this.id,
    required this.day,
    required this.time,
    required this.subject,
    required this.room,
    required this.className,
  });

  factory TeacherScheduleModel.fromJson(Map<String, dynamic> json) {
    return TeacherScheduleModel(
      id: json['id']?.toString() ?? '',
      day: json['day']?.toString() ?? json['hari']?.toString() ?? '',
      time: json['time']?.toString() ?? json['jam']?.toString() ?? '',
      subject: json['subject']?.toString() ?? json['matpel']?.toString() ?? '',
      room: json['room']?.toString() ?? json['ruangan']?.toString() ?? '',
      className:
          json['class_name']?.toString() ?? json['kelas']?.toString() ?? json['class']?.toString() ?? '',
    );
  }
}
