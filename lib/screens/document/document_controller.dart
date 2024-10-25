import 'package:flutter/material.dart';
import 'package:organize_ai_app/inputs/document_input.dart';
import 'package:organize_ai_app/inputs/update_document_input.dart';
import 'package:organize_ai_app/models/document.dart';
import 'package:organize_ai_app/models/document_pagination.dart';
import 'package:organize_ai_app/services/document_service.dart';

class DocumentController extends ChangeNotifier {
  final DocumentService _documentService = DocumentService();

  DocumentPagination? _documentPagination;
  List<Document> _documents = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<Document> get documents => _documents;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDocuments({int limit = 20, int page = 1}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _documentPagination =
          await _documentService.get(limit: limit, page: page);
      _documents = _documentPagination!.data;
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadNextPage() async {
    if (_documentPagination?.nextPageUrl != null && !_isLoading) {
      _isLoading = true;
      notifyListeners();

      try {
        _documentPagination =
            await _documentService.getNextPage(_documentPagination!);
        _documents.addAll(_documentPagination!.data);
      } catch (e) {
        _errorMessage = e.toString();
        rethrow;
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> loadPreviousPage() async {
    if (_documentPagination?.prevPageUrl != null && !_isLoading) {
      _isLoading = true;
      notifyListeners();

      try {
        _documentPagination =
            await _documentService.getPreviousPage(_documentPagination!);
        _documents = _documentPagination!.data;
      } catch (e) {
        _errorMessage = e.toString();
        rethrow;
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> createDocument(DocumentInput input) async {
    _isLoading = true;
    notifyListeners();

    try {
      final document = await _documentService.create(input);
      _documents.add(document);
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateDocument(String id, UpdateDocumentInput input) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedDocument = await _documentService.update(id, input);
      final index = _documents.indexWhere((doc) => doc.id == id);
      if (index != -1) {
        _documents[index] = updatedDocument;
      }
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteDocument(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _documentService.delete(id);
      _documents.removeWhere((doc) => doc.id == id);
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
