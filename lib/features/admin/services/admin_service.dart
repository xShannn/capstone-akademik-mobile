import '../models/admin_model.dart';
import '../models/school_stat_model.dart';

class AdminService {
  static AdminModel getAdmin() {
    return AdminModel(
      id: 'a1',
      name: 'Admin Sekolah',
      email: 'admin@ sekolah.com',
      schoolName: 'SMA Baitul Insan',
      stats: getSchoolStats(),
    );
  }

  static List<SchoolStatModel> getSchoolStats() {
    return const [
      SchoolStatModel(
        label: 'Siswa',
        value: 720,
        description: 'Total siswa aktif',
      ),
      SchoolStatModel(
        label: 'Guru',
        value: 48,
        description: 'Total guru aktif',
      ),
      SchoolStatModel(label: 'Kelas', value: 24, description: 'Jumlah kelas'),
      SchoolStatModel(
        label: 'Presensi',
        value: 98,
        description: 'Rata-rata presensi',
      ),
    ];
  }

  static List<Map<String, dynamic>> getStudents() {
    return const [
      {'id': 's1', 'name': 'Alya Rahma', 'class': 'X IPA 1', 'status': 'Aktif'},
      {
        'id': 's2',
        'name': 'Fajar Pratama',
        'class': 'VIII B',
        'status': 'Aktif',
      },
    ];
  }

  static List<Map<String, dynamic>> getTeachers() {
    return const [
      {
        'id': 't1',
        'name': 'Bu Rina',
        'subject': 'Matematika',
        'status': 'Aktif',
      },
      {'id': 't2', 'name': 'Pak Joko', 'subject': 'IPA', 'status': 'Aktif'},
    ];
  }

  static List<Map<String, dynamic>> getClasses() {
    return const [
      {'id': 'c1', 'name': 'X IPA 1', 'room': 'Lab 2', 'students': 32},
      {'id': 'c2', 'name': 'VIII B', 'room': 'Kelas 3A', 'students': 28},
    ];
  }

  static List<Map<String, String>> getAttendanceReport() {
    return const [
      {'date': '01 Jun 2026', 'present': '98%', 'notes': 'Normal'},
      {'date': '02 Jun 2026', 'present': '96%', 'notes': 'Hujan'},
      {'date': '03 Jun 2026', 'present': '97%', 'notes': 'Normal'},
    ];
  }

  static List<Map<String, String>> getNotifications() {
    return const [
      {
        'title': 'Rapat Komite Sekolah',
        'date': 'Hari ini',
        'message': 'Rapat komite dilaksanakan pukul 15.00.',
      },
      {
        'title': 'Rekap Presensi',
        'date': 'Kemarin',
        'message': 'Rekap presensi sudah siap dilihat.',
      },
    ];
  }
}
