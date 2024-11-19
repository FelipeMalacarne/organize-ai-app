import 'package:http/http.dart' as http;
import 'package:organize_ai_app/config/config.dart';
import 'package:organize_ai_app/mixins/requires_token.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:organize_ai_app/models/extraction.dart';
import 'package:organize_ai_app/models/tag.dart';

class Document with RequiresToken {
  late String id;
  late String title;
  late String fileType;

  late List<Tag> tags;
  late List<Extraction> extractions;
  late List<dynamic> metadata;

  Document({
    required this.id,
    required this.title,
    required this.fileType,
    required this.metadata,
  });

  Document.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    fileType = json['file_type'];
    tags = (json['tags'] as List<dynamic>)
        .map((tag) => Tag.fromJson(tag))
        .toList();
    if (json['metadata'] is List) {
      metadata = json['metadata'] as List<dynamic>;
    } else if (json['metadata'] is Map) {
      metadata = [json['metadata']];
    } else {
      metadata = [];
    }
    if (json['extractions'] is List) {
      extractions = (json['extractions'] as List<dynamic>)
          .map((extraction) =>
              Extraction.fromJson(extraction as Map<String, dynamic>))
          .toList();
    } else {
      extractions = [];
    }
  }

  Future<String> download() async {
    String url = '${Config.apiUrl}/document';
    final token = await getToken();

    final urlResponse = await http
        .get(Uri.parse('$url/$id/download'), headers: <String, String>{
      'Content-Type': 'application',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (urlResponse.statusCode != 200) {
      throw Exception('Failed to get download URL: ${urlResponse.statusCode}');
    }

    print(urlResponse.body);

    final response = await http.get(Uri.parse(urlResponse.body));

    if (response.statusCode == 200) {
      final directory = await getExternalStorageDirectory();
      final downloadsDirectory = Directory('${directory!.path}/Download');
      if (!await downloadsDirectory.exists()) {
        await downloadsDirectory.create(recursive: true);
      }
      final filePath = '${downloadsDirectory.path}/document_$id.$fileType';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      throw Exception('Failed to download document: ${response.statusCode}');
    }
  }
}
