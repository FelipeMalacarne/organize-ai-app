class Document {
  late String title;
  late String filePath;
  late String fileType;
  late List<dynamic> metadata;

  Document({
    required this.title,
    required this.filePath,
    required this.fileType,
    required this.metadata,
  });

  Document.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    filePath = json['filePath'];
    fileType = json['fileType'];
    metadata = json['metadata'];
  }
}
