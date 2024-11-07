class Extraction {
  late String id;
  late String object;
  late String type;

  late String? extractedText;
  late dynamic extractedJson;

  late DateTime createdAt;

  Extraction({
    required this.id,
    required this.object,
    required this.type,
    required this.extractedText,
    required this.extractedJson,
    required this.createdAt,
  });

  Extraction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    type = json['type'];
    extractedText = json['extracted_text'];
    extractedJson = json['extracted_json'];
    createdAt = DateTime.parse(json['created_at']);
  }
}
