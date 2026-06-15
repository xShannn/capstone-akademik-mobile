import '../models/child_model.dart';
import '../models/notification_model.dart';
import '../models/parent_model.dart';

class ParentService {
  static ParentModel getParent() {
    return ParentModel(
      id: 'p1',
      name: 'Ibu Siti Aminah',
      email: 'siti.aminah@example.com',
      phone: '+62 812 3456 7890',
      children: getChildren(),
    );
  }

  static List<ChildModel> getChildren() {
    return const [
      ChildModel(
        id: 'c1',
        name: 'Alya Rahma',
        nis: '22001',
        studentClass: 'X IPA 1',
        teacherName: 'Bu Rina',
        averageScore: 88.4,
        attendanceRate: 95.0,
        avatarLetter: 'AR',
      ),
      ChildModel(
        id: 'c2',
        name: 'Fajar Pratama',
        nis: '22002',
        studentClass: 'VIII B',
        teacherName: 'Pak Joko',
        averageScore: 82.1,
        attendanceRate: 92.5,
        avatarLetter: 'FP',
      ),
    ];
  }

  static List<ParentNotificationModel> getNotifications() {
    return const [
      ParentNotificationModel(
        id: 'n1',
        title: 'Jadwal Ulangan Matematika',
        description: 'Ulangan akan dilaksanakan pada Senin, 8 Juni 2026.',
        date: '2 jam lalu',
        isRead: false,
      ),
      ParentNotificationModel(
        id: 'n2',
        title: 'Raport Semester Genap',
        description: 'Nilai raport sudah tersedia di aplikasi.',
        date: 'Kemarin',
        isRead: true,
      ),
      ParentNotificationModel(
        id: 'n3',
        title: 'Izin Tidak Masuk',
        description: 'Ananda Alya Rahma sudah terkonfirmasi sakit.',
        date: '2 Mei 2026',
        isRead: true,
      ),
    ];
  }

  static List<Map<String, String>> getSchedule(String childId) {
    if (childId == 'c1') {
      return const [
        {'day': 'Senin', 'time': '08:00 - 09:30', 'subject': 'Matematika'},
        {'day': 'Selasa', 'time': '10:00 - 11:30', 'subject': 'Fisika'},
        {'day': 'Rabu', 'time': '13:00 - 14:30', 'subject': 'Bahasa Inggris'},
      ];
    }

    return const [
      {'day': 'Senin', 'time': '09:00 - 10:30', 'subject': 'IPA'},
      {'day': 'Rabu', 'time': '11:00 - 12:30', 'subject': 'Matematika'},
      {'day': 'Jumat', 'time': '13:00 - 14:30', 'subject': 'PKN'},
    ];
  }

  static List<Map<String, dynamic>> getReport(String childId) {
    if (childId == 'c1') {
      return const [
        {'subject': 'Matematika', 'score': 90},
        {'subject': 'Fisika', 'score': 87},
        {'subject': 'Bahasa Inggris', 'score': 89},
        {'subject': 'Biologi', 'score': 86},
      ];
    }

    return const [
      {'subject': 'IPA', 'score': 84},
      {'subject': 'Matematika', 'score': 80},
      {'subject': 'Bahasa Indonesia', 'score': 85},
      {'subject': 'PKN', 'score': 83},
    ];
  }

  static List<Map<String, String>> getAttendance(String childId) {
    if (childId == 'c1') {
      return const [
        {'date': '01 Jun 2026', 'status': 'Hadir'},
        {'date': '02 Jun 2026', 'status': 'Hadir'},
        {'date': '03 Jun 2026', 'status': 'Sakit'},
      ];
    }

    return const [
      {'date': '01 Jun 2026', 'status': 'Hadir'},
      {'date': '02 Jun 2026', 'status': 'Izin'},
      {'date': '03 Jun 2026', 'status': 'Hadir'},
    ];
  }
}
