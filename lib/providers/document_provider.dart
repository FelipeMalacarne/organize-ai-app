import 'package:flutter/material.dart';
import 'package:organize_ai_app/inputs/document_input.dart';
import 'package:organize_ai_app/models/document.dart';
import 'package:organize_ai_app/models/document_pagination.dart';
import 'package:organize_ai_app/models/tag.dart';
import 'package:organize_ai_app/services/document_service.dart';

class DocumentProvider with ChangeNotifier {
  final DocumentService documentService;
  List<Document> _documents = [];

  late String? _nextPageUrl;
  late String? _prevPageUrl;
  late String? _firstPageUrl;
  late String? _lastPageUrl;

  bool _isLoading = false;
  String _errorMessage = '';

  List<Document> get documents => _documents;
  String? get nextPageUrl => _nextPageUrl;
  String? get prevPageUrl => _prevPageUrl;
  String? get firstPageUrl => _firstPageUrl;
  String? get lastPageUrl => _lastPageUrl;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  DocumentProvider(this.documentService);

  Future<void> fetchDocuments({String? search}) async {
    _isLoading = true;
    notifyListeners();

    try {
      DocumentPagination pagination =
          await documentService.get(search: search ?? '');

      _documents = pagination.data;
      _nextPageUrl = pagination.nextPageUrl;
      _prevPageUrl = pagination.prevPageUrl;
      _firstPageUrl = pagination.firstPageUrl;
      _lastPageUrl = pagination.lastPageUrl;
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Document> createDocument(
      String title, List<Tag> tags, String filePath) async {
    _isLoading = true;
    notifyListeners();
    try {
      Document document = await documentService
          .create(DocumentInput(title: title, tags: tags, filePath: filePath));
      _documents.insert(0, document);
      return document;
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
