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
    this.firstPageUrl,
    this.lastPageUrl,
    this.prevPageUrl,
    this.nextPageUrl,
    required this.currentPage,
    required this.lastPage,
  });

  DocumentPagination.fromJson(Map<String, dynamic> json)
      : data = List<Document>.from(
            json['data'].map((document) => Document.fromJson(document))),
        firstPageUrl = json['links']['first'],
        lastPageUrl = json['links']['last'],
        prevPageUrl = json['links']['prev'],
        nextPageUrl = json['links']['next'],
        currentPage = json['meta']['current_page'],
        lastPage = json['meta']['last_page'];
}
