import 'package:flutter/material.dart';
import 'package:organize_ai_app/models/tag_pagination.dart';
import 'package:organize_ai_app/services/tag_service.dart';

class TagController with ChangeNotifier {
  final TagService tagService;

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  TagController(this.tagService);

  Future<TagPagination> getTags() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      return await tagService.get();
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
