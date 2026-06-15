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
}
