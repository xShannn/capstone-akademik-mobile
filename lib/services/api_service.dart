import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';

class ApiService {
  static Future<Map<String, dynamic>> login({
    required String role,
    required String email,
    required String password,
  }) async {
    String endpoint;

    // Menentukan endpoint berdasarkan role
    if (role.toLowerCase() == 'student') {
      endpoint = '/siswa/login';
    } else if (role.toLowerCase() == 'parent') {
      endpoint = '/ortu/login';
    } else {
      endpoint = '/login';
    }

    final uri = Uri.parse('$baseUrl$endpoint');

    // Menentukan payload yang dikirim
    Map<String, dynamic> payload;

    if (role.toLowerCase() == 'student') {
      payload = {'username': email, 'password': password};
    } else {
      payload = {'email': email, 'password': password};
    }

    try {
      final resp = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(payload),
      );

      final body = resp.body.isNotEmpty ? jsonDecode(resp.body) : {};

      if ((resp.statusCode == 200 || resp.statusCode == 201) &&
          body['status'] == 'success') {
        return {
          'success': true,
          'data': body['data'],
          'message': body['message'],
        };
      }

      String message = 'Login gagal (${resp.statusCode})';

      if (body is Map && body.containsKey('message')) {
        message = body['message'].toString();
      }

      return {'success': false, 'message': message, 'body': body};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
