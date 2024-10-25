import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:organize_ai_app/config/config.dart';
import 'package:organize_ai_app/exceptions/token_invalid_exception.dart';
import 'package:organize_ai_app/mixins/requires_token.dart';
import 'package:organize_ai_app/models/tag_pagination.dart';

class TagService with RequiresToken {
  String url = '${Config.apiUrl}/tag';

  Future<TagPagination> get({int limit = 40, int page = 1}) async {
    final token = await getToken();
    if (token == null) {
      throw TokenExpiredException('Token expired');
    }

    final response = await http.get(Uri.parse('$url?limit=$limit&page=$page'),
        headers: <String, String>{
          'Content-Type': 'application',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      return TagPagination.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw TokenExpiredException('Token expired');
    } else {
      var body = json.decode(response.body);

      if (body['validation'] != null && body['validation']['message'] != null) {
        throw Exception(body['validation']['message']);
      }

      throw Exception('Unknown error');
    }
  }
}
