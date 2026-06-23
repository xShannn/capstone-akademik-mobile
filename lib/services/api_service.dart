import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';

class ApiService {
  // ================= LOGIN =================

  static Future<Map<String, dynamic>> login({
    required String role,
    required String email,
    required String password,
  }) async {
    String endpoint;

    if (role.toLowerCase() == 'student') {
      endpoint = '/siswa/login';
    } else if (role.toLowerCase() == 'parent') {
      endpoint = '/ortu/login';
    } else {
      endpoint = '/login';
    }

    final uri = Uri.parse('$baseUrl$endpoint');

    Map<String, dynamic> payload;

    if (role.toLowerCase() == 'student') {
      payload = {'username': email, 'password': password};
    } else {
      payload = {'email': email, 'password': password};
    }

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(payload),
      );

      final body = response.body.isNotEmpty ? jsonDecode(response.body) : {};

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          body['status'] == 'success') {
        return {
          'success': true,
          'data': body['data'],
          'message': body['message'],
        };
      }

      return {'success': false, 'message': body['message'] ?? 'Login gagal'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ================= GET =================

  static Future<Map<String, dynamic>> getData({
    required String endpoint,
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'status': body['status'],
          'data': body['data'],
          'message': body['message'],
        };
      }

      return {
        'success': false,
        'message': body['message'] ?? 'Gagal mengambil data',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ================= POST =================

  static Future<Map<String, dynamic>> postData({
    required String endpoint,
    required String token,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      final body = jsonDecode(response.body);

      return {
        'success': response.statusCode == 200 || response.statusCode == 201,

        'status': body['status'],

        'message': body['message'],

        'data': body['data'],
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ================= PUT =================

  static Future<Map<String, dynamic>> putData({
    required String endpoint,
    required String token,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),

        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },

        body: jsonEncode(data),
      );

      final body = jsonDecode(response.body);

      return {
        'success': response.statusCode == 200 || response.statusCode == 201,

        'status': body['status'],

        'message': body['message'],

        'data': body['data'],
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ================= DELETE =================

  static Future<Map<String, dynamic>> deleteData({
    required String endpoint,
    required String token,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),

        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final body = jsonDecode(response.body);

      return {
        'success': response.statusCode == 200 || response.statusCode == 201,

        'status': body['status'],

        'message': body['message'],
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ================= LOGOUT =================

  static Future<void> logout(String token) async {
    try {
      await http.post(
        Uri.parse('$baseUrl/logout'),

        headers: {'Authorization': 'Bearer $token'},
      );
    } catch (_) {}
  }
}
