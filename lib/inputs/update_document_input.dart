import 'package:organize_ai_app/models/tag.dart';

class UpdateDocumentInput {
  final String title;
  final List<Tag> tags;

  UpdateDocumentInput({
    required this.title,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'tags': tags.map((tag) => tag.name).toList(),
    };
  }
}
