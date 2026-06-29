import 'package:mobile_sekolah/services/api_service.dart';
import 'package:mobile_sekolah/services/storage_service.dart';

class AdminService {
  // ==========================================
  // DASHBOARD & ADMIN INFO
  // ==========================================
  static Future<Map<String, dynamic>> getDashboard() async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.getData(endpoint: '/admin/dashboard', token: token);
  }

  static Future<Map<String, dynamic>?> getAdmin() async {
    return await StorageService.getUser();
  }

  // ==========================================
  // FUNGSI BANTUAN UNTUK PARSING LIST
  // ==========================================
  static List<Map<String, dynamic>> _extractList(
    dynamic result,
    String customKey,
  ) {
    if (result == null) return [];

    if (result is List) {
      return result
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    }

    if (result is Map<String, dynamic>) {
      if (result['data'] is Map<String, dynamic>) {
        if (result['data'][customKey] is List) {
          return (result['data'][customKey] as List)
              .map((item) => Map<String, dynamic>.from(item as Map))
              .toList();
        }

        if (result['data']['data'] is List) {
          return (result['data']['data'] as List)
              .map((item) => Map<String, dynamic>.from(item as Map))
              .toList();
        }
      }

      if (result['data'] is List) {
        return (result['data'] as List)
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();
      }

      if (result[customKey] is List) {
        return (result[customKey] as List)
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();
      }
    }

    return [];
  }

  // ==========================================
  // MANAGE STUDENTS (SISWA)
  // ==========================================
  static Future<List<Map<String, dynamic>>> getStudents() async {
    final token = await StorageService.getToken();
    if (token == null) return [];

    final result = await ApiService.getData(
      endpoint: '/admin/students',
      token: token,
    );

    return _extractList(result, 'students');
  }

  static Future<Map<String, dynamic>> createStudent(
    Map<String, dynamic> data,
  ) async {
    final token = await StorageService.getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.postData(
      endpoint: '/admin/students',
      token: token,
      data: data,
    );
  }

  static Future<Map<String, dynamic>> updateStudent(
    int id,
    Map<String, dynamic> data,
  ) async {
    final token = await StorageService.getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.putData(
      endpoint: '/admin/students/$id',
      token: token,
      data: data,
    );
  }

  static Future<Map<String, dynamic>> deleteStudent(int id) async {
    final token = await StorageService.getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.deleteData(
      endpoint: '/admin/students/$id',
      token: token,
    );
  }

  // ==========================================
  // MANAGE TEACHERS (GURU)
  // ==========================================
  static Future<List<Map<String, dynamic>>> getTeachers() async {
    final token = await StorageService.getToken();
    if (token == null) return [];

    final result = await ApiService.getData(
      endpoint: '/admin/teachers',
      token: token,
    );

    return _extractList(result, 'teachers');
  }

  static Future<Map<String, dynamic>> createTeacher(
    Map<String, dynamic> data,
  ) async {
    final token = await StorageService.getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.postData(
      endpoint: '/admin/teachers',
      token: token,
      data: data,
    );
  }

  static Future<Map<String, dynamic>> updateTeacher(
    int id,
    Map<String, dynamic> data,
  ) async {
    final token = await StorageService.getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.putData(
      endpoint: '/admin/teachers/$id',
      token: token,
      data: data,
    );
  }

  static Future<Map<String, dynamic>> deleteTeacher(int id) async {
    final token = await StorageService.getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.deleteData(
      endpoint: '/admin/teachers/$id',
      token: token,
    );
  }

  // ==========================================
  // MANAGE CLASSES (KELAS)
  // ==========================================
  static Future<List<Map<String, dynamic>>> getClasses() async {
    final token = await StorageService.getToken();
    if (token == null) return [];

    final result = await ApiService.getData(
      endpoint: '/admin/classrooms',
      token: token,
    );

    // FIX UTAMA: Menggunakan key 'classrooms' agar sesuai dengan hasil DataMasterController
    return _extractList(result, 'classrooms');
  }

  static Future<Map<String, dynamic>> createClass(
    Map<String, dynamic> data,
  ) async {
    final token = await StorageService.getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.postData(
      endpoint: '/admin/classrooms',
      token: token,
      data: data,
    );
  }

  static Future<Map<String, dynamic>> updateClass(
    int id,
    Map<String, dynamic> data,
  ) async {
    final token = await StorageService.getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.putData(
      endpoint: '/admin/classrooms/$id',
      token: token,
      data: data,
    );
  }

  static Future<Map<String, dynamic>> deleteClass(int id) async {
    final token = await StorageService.getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.deleteData(
      endpoint: '/admin/classrooms/$id',
      token: token,
    );
  }

  // ==========================================
  // ATTENDANCE REPORT (LAPORAN PRESENSI)
  // ==========================================
  static Future<List<Map<String, dynamic>>> getAttendanceReport() async {
    final token = await StorageService.getToken();
    if (token == null) return [];

    final result = await ApiService.getData(
      endpoint: '/admin/attendance-report',
      token: token,
    );

    return _extractList(result, 'reports');
  }

  // ==========================================
  // NOTIFICATIONS (NOTIFIKASI)
  // ==========================================
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final token = await StorageService.getToken();
    if (token == null) return [];

    final result = await ApiService.getData(
      endpoint: '/admin/notifications',
      token: token,
    );

    return _extractList(result, 'notifications');
  }
}
