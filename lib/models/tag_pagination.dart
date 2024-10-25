import 'package:organize_ai_app/models/tag.dart';

class TagPagination {
  List<Tag> data;

  String? firstPageUrl;
  String? lastPageUrl;
  String? prevPageUrl;
  String? nextPageUrl;

  int currentPage;
  int lastPage;

  TagPagination({
    required this.data,
    required this.firstPageUrl,
    required this.lastPageUrl,
    required this.prevPageUrl,
    required this.nextPageUrl,
    required this.currentPage,
    required this.lastPage,
  });

  factory TagPagination.fromJson(Map<String, dynamic> json) {
    return TagPagination(
      data: json['data'] != null
          ? List<Tag>.from(
              json['data'].map((document) => Tag.fromJson(document)))
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
