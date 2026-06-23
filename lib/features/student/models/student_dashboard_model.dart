class StudentDashboardModel {
  final String name;
  final String role;
  final String className;
  final double attendanceRate;
  final double averageScore;
  final int taskCount;

  StudentDashboardModel({
    required this.name,
    required this.role,
    required this.className,
    required this.attendanceRate,
    required this.averageScore,
    required this.taskCount,
  });

  factory StudentDashboardModel.fromJson(Map<String, dynamic> json) {
    final student = json['student'] ?? json['data']?['student'] ?? {};
    final classroom = student['classroom'] ?? student['kelas'] ?? {};
    return StudentDashboardModel(
      name:
          student['nama_lengkap']?.toString() ??
          student['name']?.toString() ??
          '',
      role: student['role']?.toString() ?? 'Student',
      className:
          classroom['nama_kelas']?.toString() ??
          classroom['name']?.toString() ??
          '',
      attendanceRate:
          double.tryParse(
            json['persentase_hadir']?.toString() ??
                json['attendance_rate']?.toString() ??
                '0',
          ) ??
          0,
      averageScore:
          double.tryParse(
            json['rata_nilai']?.toString() ??
                json['average_score']?.toString() ??
                '0',
          ) ??
          0,
      taskCount:
          int.tryParse(
            json['jumlah_tugas']?.toString() ??
                json['task_count']?.toString() ??
                '0',
          ) ??
          0,
    );
  }
}
