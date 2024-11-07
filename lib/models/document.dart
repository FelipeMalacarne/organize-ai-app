import 'package:organize_ai_app/models/extraction.dart';
import 'package:organize_ai_app/models/tag.dart';

class Document {
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
}
