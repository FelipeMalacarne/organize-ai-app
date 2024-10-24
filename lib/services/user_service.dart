import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:organize_ai_app/config/config.dart';
import 'package:organize_ai_app/exceptions/token_invalid_exception.dart';
import 'package:organize_ai_app/mixins/requires_token.dart';
import 'package:organize_ai_app/models/user.dart';

class UserService with RequiresToken {
  String url = '${Config.apiUrl}/user';

  Future<User> getSelf() async {
    final token = await getToken();
    if (token == null) {
      throw TokenExpiredException('Token invalid');
    }

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw TokenExpiredException('Token invalid');
    } else {
      throw Exception('Failed to load user');
    }
  }
}
