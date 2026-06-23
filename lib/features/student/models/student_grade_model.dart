class StudentGradeModel {
  final String id;
  final String subject;
  final String score;
  final String grade;
  final String type;

  StudentGradeModel({
    required this.id,
    required this.subject,
    required this.score,
    required this.grade,
    required this.type,
  });

  factory StudentGradeModel.fromJson(Map<String, dynamic> json) {
    return StudentGradeModel(
      id: json['id']?.toString() ?? '',
      subject:
          json['subject']?.toString() ??
          json['mata_pelajaran']?.toString() ??
          json['nama_mapel']?.toString() ??
          '-',
      score: json['score']?.toString() ?? json['nilai']?.toString() ?? '0',
      grade: json['grade']?.toString() ?? json['letter']?.toString() ?? '-',
      type: json['type']?.toString() ?? json['category']?.toString() ?? '-',
    );
  }
}
