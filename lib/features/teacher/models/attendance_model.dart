enum AttendanceStatus { present, absent, late }

class AttendanceModel {
  final String studentName;
  final String nis;
  AttendanceStatus status;
  final String detail;

  AttendanceModel({
    required this.studentName,
    required this.nis,
    required this.status,
    required this.detail,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    final rawStatus = json['status']?.toString().toLowerCase() ?? '';
    AttendanceStatus status;
    if (rawStatus.contains('hadir') || rawStatus.contains('present')) {
      status = AttendanceStatus.present;
    } else if (rawStatus.contains('izin') || rawStatus.contains('leave')) {
      status = AttendanceStatus.late;
    } else {
      status = AttendanceStatus.absent;
    }

    return AttendanceModel(
      studentName:
          json['student_name']?.toString() ?? json['name']?.toString() ?? '',
      nis: json['nis']?.toString() ?? json['student_id']?.toString() ?? '',
      status: status,
      detail: json['detail']?.toString() ?? json['notes']?.toString() ?? '',
    );
  }
}
