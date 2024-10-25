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
    Map<String, dynamic> json = {
      'title': title,
    };

    for (int i = 0; i < tags.length; i++) {
      json['tags[$i]'] = tags[i];
    }

    return json;
  }
}
