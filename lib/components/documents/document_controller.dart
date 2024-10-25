import 'package:flutter/material.dart';
import 'package:organize_ai_app/inputs/document_input.dart';
import 'package:organize_ai_app/inputs/update_document_input.dart';
import 'package:organize_ai_app/models/document.dart';
import 'package:organize_ai_app/models/document_pagination.dart';
import 'package:organize_ai_app/models/tag.dart';
import 'package:organize_ai_app/services/document_service.dart';

class DocumentController with ChangeNotifier {
  final DocumentService documentService;

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  DocumentController(this.documentService);

  Future<DocumentPagination> getDocuments() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      return await documentService.get();
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<DocumentPagination> getNextPage(DocumentPagination pagination) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      return await documentService.getNextPage(pagination);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<DocumentPagination> getPreviousPage(
      DocumentPagination pagination) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      return await documentService.getPreviousPage(pagination);
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Document> getDocumentById(String id) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      return await documentService.getById(id);
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Document> createDocument(
      String title, List<Tag> tags, String filePath) async {
    final documentInput = DocumentInput(
      title: title,
      tags: tags,
      filePath: filePath,
    );

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      return await documentService.create(documentInput);
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateDocument(
      String id, String title, List<String> tags, String filePath) async {
    final documentInput = UpdateDocumentInput(
      title: title,
      tags: tags,
    );

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await documentService.update(id, documentInput);
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteDocument(String id) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await documentService.delete(id);
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
