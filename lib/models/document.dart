class Document {
  late String id;
  late String title;
  late String filePath;
  late String fileType;
  late List<dynamic> metadata;

  Document({
    required this.id,
    required this.title,
    required this.filePath,
    required this.fileType,
    required this.metadata,
  });

  Document.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    filePath = json['filePath'];
    fileType = json['fileType'];
    metadata = json['metadata'];
  }
}
