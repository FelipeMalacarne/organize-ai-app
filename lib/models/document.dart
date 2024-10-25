class Document {
  late String id;
  late String title;
  late String fileType;

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
    metadata = json['metadata'] ?? [];
  }
}
