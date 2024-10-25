import 'package:organize_ai_app/models/document.dart';

class DocumentPagination {
  List<Document> data;

  String? firstPageUrl;
  String? lastPageUrl;
  String? prevPageUrl;
  String? nextPageUrl;

  int currentPage;
  int lastPage;

  DocumentPagination({
    required this.data,
    required this.firstPageUrl,
    required this.lastPageUrl,
    required this.prevPageUrl,
    required this.nextPageUrl,
    required this.currentPage,
    required this.lastPage,
  });

  factory DocumentPagination.fromJson(Map<String, dynamic> json) {
    return DocumentPagination(
      data: json['data'] != null
          ? List<Document>.from(
              json['data'].map((document) => Document.fromJson(document)))
          : [],
      firstPageUrl: json['links']['first'],
      lastPageUrl: json['links']['last'],
      prevPageUrl: json['links']['prev'],
      nextPageUrl: json['links']['next'],
      currentPage: json['meta']['current_page'],
      lastPage: json['meta']['last_page'],
    );
  }
}
