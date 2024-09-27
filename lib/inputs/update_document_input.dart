class UpdateDocumentInput {
  final String title;
  final List<String> tags;

  UpdateDocumentInput({
    required this.title,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'tags': tags,
    };
  }
}
