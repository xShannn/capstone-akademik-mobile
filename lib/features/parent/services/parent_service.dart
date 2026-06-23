import 'package:mobile_sekolah/features/parent/models/parent_model.dart';
import 'package:mobile_sekolah/services/api_service.dart';
import 'package:mobile_sekolah/services/storage_service.dart';

class ParentService {
  static Future<Map<String, dynamic>> getDashboard() async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.getData(endpoint: '/ortu/dashboard', token: token);
  }

  static Future<ParentModel?> getParent() async {
    final result = await getDashboard();
    if (result['success'] != true) {
      final user = await StorageService.getUser();
      if (user != null) {
        return ParentModel.fromJson(user);
      }
      return null;
    }

    final data = result['data'];
    if (data is Map<String, dynamic>) {
      return ParentModel.fromJson(data);
    }
    return null;
  }

  static Future<Map<String, dynamic>> getSchedule(String childId) async {
    return await getChildSchedule(childId);
  }

  static Future<Map<String, dynamic>> getAttendance(String childId) async {
    return await getChildAttendance(childId);
  }

  static Future<Map<String, dynamic>> getReport(String childId) async {
    return await getChildReport(childId);
  }

  static Future<Map<String, dynamic>> getChildSchedule(String childId) async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.getData(
      endpoint: '/ortu/child/$childId/schedule',
      token: token,
    );
  }

  static Future<Map<String, dynamic>> getChildAttendance(String childId) async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.getData(
      endpoint: '/ortu/child/$childId/attendance',
      token: token,
    );
  }

  static Future<Map<String, dynamic>> getChildReport(String childId) async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.getData(
      endpoint: '/ortu/child/$childId/grades',
      token: token,
    );
  }

  static Future<Map<String, dynamic>> getNotifications() async {
    final token = await StorageService.getToken();

    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan'};
    }

    return await ApiService.getData(
      endpoint: '/ortu/notifications',
      token: token,
    );
  }
}
