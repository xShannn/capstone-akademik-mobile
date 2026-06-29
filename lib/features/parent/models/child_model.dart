class ChildModel {
  final String id;
  final String name;
  final String nis;
  final String studentClass;
  final String teacherName;
  final double averageScore;
  final double attendanceRate;
  final String avatarLetter;

  const ChildModel({
    required this.id,
    required this.name,
    required this.nis,
    required this.studentClass,
    required this.teacherName,
    required this.averageScore,
    required this.attendanceRate,
    required this.avatarLetter,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    final name = json['name']?.toString() ?? '';
    final avatar =
        json['avatar_letter']?.toString() ??
        json['initials']?.toString() ??
        (name.isNotEmpty
            ? name
                  .split(' ')
                  .where((part) => part.isNotEmpty)
                  .map((part) => part[0])
                  .take(2)
                  .join()
                  .toUpperCase()
            : '');

    return ChildModel(
      id: json['id']?.toString() ?? json['child_id']?.toString() ?? '',
      name: name,
      nis: json['nis']?.toString() ?? json['student_number']?.toString() ?? '',
      studentClass:
          json['class']?.toString() ?? json['student_class']?.toString() ?? '',
      teacherName:
          json['teacher_name']?.toString() ??
          json['guardian']?.toString() ??
          '',
      averageScore:
          double.tryParse(json['average_score']?.toString() ?? '') ??
          double.tryParse(json['grade_average']?.toString() ?? '') ??
          0,
      attendanceRate:
          double.tryParse(json['attendance_rate']?.toString() ?? '') ?? 0,
      avatarLetter: avatar,
    );
  }
}
