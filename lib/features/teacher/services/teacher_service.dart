import 'package:mobile_sekolah/features/teacher/models/attendance_model.dart';
import 'package:mobile_sekolah/features/teacher/models/teacher_class_model.dart';
import 'package:mobile_sekolah/features/teacher/models/teacher_schedule_model.dart';
import 'package:mobile_sekolah/services/api_service.dart';
import 'package:mobile_sekolah/services/storage_service.dart';

class TeacherService {
  static Future<Map<String, dynamic>> getDashboard() async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.getData(endpoint: '/guru/dashboard', token: token);
  }

  static Future<List<TeacherClassModel>> getTeacherClasses() async {
    final result = await getDashboard();
    if (result['success'] != true) return [];

    final data = result['data'];
    if (data is Map<String, dynamic>) {
      final classes = data['classes'] ?? data['teacher_classes'] ?? [];
      if (classes is List) {
        return classes
            .map(
              (item) => TeacherClassModel.fromJson(
                Map<String, dynamic>.from(item as Map),
              ),
            )
            .toList();
      }
    }
    return [];
  }

  // ================= SCHEDULES =================

  static Future<List<TeacherScheduleModel>> getTeacherSchedule() async {
    final result = await getDashboard();
    if (result['success'] != true) return [];

    final data = result['data'];
    if (data is Map<String, dynamic>) {
      final schedule = data['schedule'] ?? data['teacher_schedule'] ?? [];
      if (schedule is List) {
        return schedule
            .map(
              (item) => TeacherScheduleModel.fromJson(
                Map<String, dynamic>.from(item as Map),
              ),
            )
            .toList();
      }
    }
    return [];
  }

  static Future<Map<String, dynamic>> createSchedule(Map<String, dynamic> data) async {
    final token = await StorageService.getToken();
    if (token == null) return {'success': false, 'message': 'Token tidak ditemukan'};
    return await ApiService.postData(
      endpoint: '/guru/schedules',
      token: token,
      data: data,
    );
  }

  static Future<Map<String, dynamic>> updateSchedule(String id, Map<String, dynamic> data) async {
    final token = await StorageService.getToken();
    if (token == null) return {'success': false, 'message': 'Token tidak ditemukan'};
    return await ApiService.putData(
      endpoint: '/guru/schedules/$id',
      token: token,
      data: data,
    );
  }

  static Future<Map<String, dynamic>> deleteSchedule(String id) async {
    final token = await StorageService.getToken();
    if (token == null) return {'success': false, 'message': 'Token tidak ditemukan'};
    return await ApiService.deleteData(
      endpoint: '/guru/schedules/$id',
      token: token,
    );
  }

  // ================= GRADES =================

  static Future<Map<String, dynamic>> saveGrade(Map<String, dynamic> data) async {
    final token = await StorageService.getToken();
    if (token == null) return {'success': false, 'message': 'Token tidak ditemukan'};
    // API endpoint assumes /guru/grades
    return await ApiService.postData(
      endpoint: '/guru/grades',
      token: token,
      data: data,
    );
  }

  static Future<Map<String, dynamic>> updateGrade(String id, Map<String, dynamic> data) async {
    final token = await StorageService.getToken();
    if (token == null) return {'success': false, 'message': 'Token tidak ditemukan'};
    return await ApiService.putData(
      endpoint: '/guru/grades/$id',
      token: token,
      data: data,
    );
  }

  // ================= STUDENTS & ATTENDANCE =================

  static Future<List<Map<String, dynamic>>> getStudentsByClass(
    String classId,
  ) async {
    final token = await StorageService.getToken();

    if (token == null) {
      return [];
    }

    final result = await ApiService.getData(
      endpoint: '/guru/class/$classId/students',
      token: token,
    );

    if (result['success'] != true) return [];
    final data = result['data'];
    if (data is List) {
      return data
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    }
    if (data is Map<String, dynamic> && data['students'] is List) {
      return (data['students'] as List)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    }
    return [];
  }

  static Future<List<AttendanceModel>> getAttendanceList() async {
    final token = await StorageService.getToken();

    if (token == null) {
      return [];
    }

    final result = await ApiService.getData(
      endpoint: '/guru/attendance',
      token: token,
    );
    if (result['success'] != true) return [];

    final data = result['data'];
    if (data is List) {
      return data
          .map(
            (item) => AttendanceModel.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();
    }
    if (data is Map<String, dynamic> && data['attendance'] is List) {
      return (data['attendance'] as List)
          .map(
            (item) => AttendanceModel.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();
    }
    return [];
  }
}
