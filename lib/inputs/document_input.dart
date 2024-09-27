class DocumentInput {
  final String title;
  final List<String> tags;
  final String filePath;

  DocumentInput({
    required this.title,
    required this.tags,
    required this.filePath,
  });

  String getFilePath() {
    return filePath;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'tags': tags,
    };
  }
}
