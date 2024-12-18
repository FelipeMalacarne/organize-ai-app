import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:organize_ai_app/config/config.dart';
import 'package:organize_ai_app/exceptions/no_pagination_available_exception.dart';
import 'package:organize_ai_app/exceptions/token_invalid_exception.dart';
import 'package:organize_ai_app/inputs/document_input.dart';
import 'package:organize_ai_app/inputs/update_document_input.dart';
import 'package:organize_ai_app/mixins/requires_token.dart';
import 'package:organize_ai_app/models/document.dart';
import 'package:organize_ai_app/models/document_pagination.dart';
import 'package:path/path.dart' as path;

class DocumentService with RequiresToken {
  String url = '${Config.apiUrl}/document';

  Future<DocumentPagination> get(
      {int limit = 20, int page = 1, String search = ''}) async {
    final token = await getToken();
    if (token == null) {
      throw TokenExpiredException('Token expired');
    }

    String uriString = '$url?limit=$limit&page=$page';

    if (search.isNotEmpty) {
      uriString += '&title=$search';
    }

    final response =
        await http.get(Uri.parse(uriString), headers: <String, String>{
      'Content-Type': 'application',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      return DocumentPagination.fromJson(json.decode(response.body));
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

  Future<DocumentPagination> getNextPage(DocumentPagination pagination) async {
    if (pagination.nextPageUrl == null) {
      throw NoPaginationAvailableException('No next page available');
    }

    final token = await getToken();
    if (token == null) {
      throw TokenExpiredException('Token expired');
    }

    final response = await http
        .get(Uri.parse(pagination.nextPageUrl ?? ''), headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      return DocumentPagination.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw TokenExpiredException('Token expired');
    } else {
      throw Exception('Failed to load documents');
    }
  }

  Future<DocumentPagination> getPreviousPage(
      DocumentPagination pagination) async {
    if (pagination.prevPageUrl == null) {
      throw NoPaginationAvailableException('No previous page available');
    }

    final token = await getToken();
    if (token == null) {
      throw TokenExpiredException('Token expired');
    }

    final response = await http
        .get(Uri.parse(pagination.prevPageUrl ?? ''), headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      return DocumentPagination.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw TokenExpiredException('Token expired');
    } else {
      throw Exception('Failed to load documents');
    }
  }

  Future<Document> getById(String id) async {
    final token = await getToken();
    if (token == null) {
      throw TokenExpiredException('Token expired');
    }

    final response =
        await http.get(Uri.parse('$url/$id'), headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      return Document.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw TokenExpiredException('Token expired');
    } else {
      throw Exception('Failed to load document');
    }
  }

  Future<Document> create(DocumentInput input) async {
    final token = await getToken();
    if (token == null) {
      throw TokenExpiredException('Token expired');
    }

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields.addAll(
          input.toJson().map((key, value) => MapEntry(key, value.toString())))
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json'
      ..files.add(await http.MultipartFile.fromPath(
          'document', input.getFilePath(),
          filename: path.basename(input.getFilePath())));

    var response = await request.send();

    final body = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Document.fromJson(body['data']);
    } else if (response.statusCode == 401) {
      throw TokenExpiredException('Token expired');
    } else {
      if (body['validation'] != null && body['validation']['message'] != null) {
        throw Exception(body['validation']['message']);
      }

      throw Exception('Unknown error');
    }
  }

  Future<Document> update(String id, UpdateDocumentInput input) async {
    final token = await getToken();
    if (token == null) {
      throw TokenExpiredException('Token expired');
    }

    final response = await http.put(Uri.parse('$url/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(input.toJson()));

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return Document.fromJson(body['data']);
    } else if (response.statusCode == 401) {
      throw TokenExpiredException('Token expired');
    } else {
      throw Exception('Failed to update document');
    }
  }

  Future<void> delete(String id) async {
    final token = await getToken();
    if (token == null) {
      throw TokenExpiredException('Token expired');
    }

    final response =
        await http.delete(Uri.parse('$url/$id'), headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      throw TokenExpiredException('Token expired');
    } else {
      throw Exception('Failed to delete document');
    }
  }
}
