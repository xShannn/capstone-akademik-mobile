class StudentTaskModel {
  final String id;
  final String title;
  final String description;
  final String teacher;
  final String deadline;
  final bool isDone;

  StudentTaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.teacher,
    required this.deadline,
    required this.isDone,
  });

  factory StudentTaskModel.fromJson(Map<String, dynamic> json) {
    final allocation =
        json['teacherAllocation'] ?? json['teacher_allocation'] ?? {};
    final teacher = allocation['teacher'] ?? allocation['guru'] ?? {};
    return StudentTaskModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? json['judul']?.toString() ?? '-',
      description:
          json['description']?.toString() ??
          json['keterangan']?.toString() ??
          '-',
      teacher:
          teacher['nama_lengkap']?.toString() ??
          teacher['name']?.toString() ??
          '-',
      deadline:
          json['deadline']?.toString() ?? json['due_date']?.toString() ?? '-',
      isDone:
          json['isDone'] == true ||
          json['is_done'] == true ||
          json['status']?.toString().toLowerCase() == 'done',
    );
  }
}
