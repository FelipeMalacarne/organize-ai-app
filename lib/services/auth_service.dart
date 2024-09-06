import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/config.dart';

class AuthService {
  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${Config.apiUrl}/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['access_token'];
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String> register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    final response = await http.post(
      Uri.parse('${Config.apiUrl}/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['access_token'];
    } else {
      throw Exception('Failed to register');
    }
  }
}
