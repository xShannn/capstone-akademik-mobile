import 'package:mobile_sekolah/services/api_service.dart';
import 'package:mobile_sekolah/services/storage_service.dart';

class StudentService {
  // ================= DASHBOARD =================

  static Future<Map<String, dynamic>> getDashboard() async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan',
      };
    }

    return await ApiService.getData(
      endpoint: '/siswa/dashboard',
      token: token,
    );
  }

  // ================= JADWAL =================

  static Future<Map<String, dynamic>> getSchedule() async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan',
      };
    }

    return await ApiService.getData(
      endpoint: '/siswa/jadwal',
      token: token,
    );
  }

  static Future<List<Map<String, dynamic>>> getScheduleList() async {
    final result = await getSchedule();

    if (result['status'] != 'success' &&
        result['success'] != true) {
      return [];
    }

    final data = result['data'];

    if (data is List) {
      return List<Map<String, dynamic>>.from(data);
    }

    if (data is Map) {
      final list =
          data['schedule'] ??
          data['schedules'] ??
          data['data'] ??
          [];

      if (list is List) {
        return List<Map<String, dynamic>>.from(list);
      }
    }

    return [];
  }

  // ================= RAPOR =================

  static Future<Map<String, dynamic>> getGrades() async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan',
      };
    }

    return await ApiService.getData(
      endpoint: '/siswa/rapor',
      token: token,
    );
  }

  static Future<List<Map<String, dynamic>>> getGradeList() async {
    final result = await getGrades();

    if (result['status'] != 'success' &&
        result['success'] != true) {
      return [];
    }

    final data = result['data'];

    if (data is List) {
      return List<Map<String, dynamic>>.from(data);
    }

    if (data is Map) {
      final list =
          data['grades'] ??
          data['data'] ??
          [];

      if (list is List) {
        return List<Map<String, dynamic>>.from(list);
      }
    }

    return [];
  }

  // ================= TUGAS =================

  static Future<Map<String, dynamic>> getTasks() async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan',
      };
    }

    return await ApiService.getData(
      endpoint: '/siswa/tugas',
      token: token,
    );
  }

  static Future<List<Map<String, dynamic>>> getTaskList() async {
    final result = await getTasks();

    if (result['status'] != 'success' &&
        result['success'] != true) {
      return [];
    }

    final data = result['data'];

    if (data is List) {
      return List<Map<String, dynamic>>.from(data);
    }

    if (data is Map) {
      final list =
          data['tasks'] ??
          data['data'] ??
          [];

      if (list is List) {
        return List<Map<String, dynamic>>.from(list);
      }
    }

    return [];
  }

  // ================= RIWAYAT PRESENSI =================

  static Future<Map<String, dynamic>> getAttendance() async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan',
      };
    }

    return await ApiService.getData(
      endpoint: '/siswa/attendance',
      token: token,
    );
  }

  static Future<List<Map<String, dynamic>>> getAttendanceHistory() async {
    final result = await getAttendance();

    if (result['status'] != 'success' &&
        result['success'] != true) {
      return [];
    }

    final data = result['data'];

    if (data is List) {
      return List<Map<String, dynamic>>.from(data);
    }

    if (data is Map) {
      final list =
          data['attendance'] ??
          data['data'] ??
          [];

      if (list is List) {
        return List<Map<String, dynamic>>.from(list);
      }
    }

    return [];
  }

  // ================= SUBMIT QR PRESENSI =================

  static Future<Map<String, dynamic>> submitAttendance({
    required int scheduleId,
    required int teacherAllocationId,
  }) async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan',
      };
    }

    return await ApiService.postData(
      endpoint: '/siswa/attendance',
      token: token,
      data: {
        'schedule_id': scheduleId,
        'teacher_allocation_id': teacherAllocationId,
      },
    );
  }
}
