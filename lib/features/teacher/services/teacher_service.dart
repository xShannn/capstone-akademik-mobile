import '../models/attendance_model.dart';
import '../models/teacher_class_model.dart';
import '../models/teacher_schedule_model.dart';

class TeacherService {
  static List<TeacherClassModel> getTeacherClasses() {
    return const [
      TeacherClassModel(
        id: 'xipa1',
        name: 'X IPA 1',
        subject: 'Matematika',
        studentCount: 32,
        attendanceRate: 94.5,
        room: 'Lab 2',
      ),
      TeacherClassModel(
        id: 'xipa2',
        name: 'X IPA 2',
        subject: 'Fisika',
        studentCount: 28,
        attendanceRate: 91.2,
        room: 'Kelas 5B',
      ),
      TeacherClassModel(
        id: 'xiips',
        name: 'X IPS 1',
        subject: 'Bahasa Inggris',
        studentCount: 30,
        attendanceRate: 96.0,
        room: 'Kelas 3A',
      ),
    ];
  }

  static List<TeacherScheduleModel> getTeacherSchedule() {
    return const [
      TeacherScheduleModel(
        day: 'Senin',
        time: '08:00 - 09:30',
        subject: 'Matematika',
        room: 'X IPA 1',
        className: 'Lab 2',
      ),
      TeacherScheduleModel(
        day: 'Selasa',
        time: '10:00 - 11:30',
        subject: 'Fisika',
        room: 'X IPA 2',
        className: 'Kelas 5B',
      ),
      TeacherScheduleModel(
        day: 'Rabu',
        time: '13:00 - 14:30',
        subject: 'Bahasa Inggris',
        room: 'X IPS 1',
        className: 'Kelas 3A',
      ),
    ];
  }

  static List<Map<String, dynamic>> getStudentsByClass(String classId) {
    final students = {
      'xipa1': [
        {
          'id': 's1',
          'name': 'Rafi Ahmad',
          'nis': '12001',
          'score': 88,
          'attendance': 96,
        },
        {
          'id': 's2',
          'name': 'Maya Putri',
          'nis': '12002',
          'score': 92,
          'attendance': 98,
        },
      ],
      'xipa2': [
        {
          'id': 's3',
          'name': 'Yoga Pratama',
          'nis': '12011',
          'score': 81,
          'attendance': 94,
        },
        {
          'id': 's4',
          'name': 'Nadia Sari',
          'nis': '12012',
          'score': 86,
          'attendance': 92,
        },
      ],
      'xiips': [
        {
          'id': 's5',
          'name': 'Dewi Lestari',
          'nis': '12021',
          'score': 90,
          'attendance': 97,
        },
      ],
    };

    return students[classId] ?? [];
  }

  static List<AttendanceModel> getAttendanceList() {
    return [
      AttendanceModel(
        studentName: 'Rafi Ahmad',
        nis: '12001',
        status: AttendanceStatus.present,
        detail: 'Masuk tepat waktu',
      ),
      AttendanceModel(
        studentName: 'Maya Putri',
        nis: '12002',
        status: AttendanceStatus.present,
        detail: 'Sedang praktik',
      ),
      AttendanceModel(
        studentName: 'Yoga Pratama',
        nis: '12011',
        status: AttendanceStatus.absent,
        detail: 'Izin sakit',
      ),
      AttendanceModel(
        studentName: 'Nadia Sari',
        nis: '12012',
        status: AttendanceStatus.late,
        detail: 'Terlambat 5 menit',
      ),
    ];
  }
}
