import 'dart:async';

import 'package:flutter/material.dart';
import 'package:organize_ai_app/screens/document/document_controller.dart';
import 'package:organize_ai_app/components/documents/document_creation_form.dart';
import 'package:organize_ai_app/components/documents/document_grid.dart';
import 'package:organize_ai_app/exceptions/token_invalid_exception.dart';
import 'package:organize_ai_app/models/document.dart';
import 'package:organize_ai_app/models/document_pagination.dart';
import 'package:organize_ai_app/models/tag.dart';
import 'package:organize_ai_app/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class DocumentOverviewPage extends StatefulWidget {
  const DocumentOverviewPage({super.key});

  @override
  DocumentOverviewState createState() => DocumentOverviewState();
}

class DocumentOverviewState extends State<DocumentOverviewPage> {
  bool _isLoading = true;
  bool _createDocumentButtonTapped = false;

  late DocumentController documentController;
  late List<Document> documents = [];

  late String? nextPageUrl;
  late String? prevPageUrl;
  late String? firstPageUrl;
  late String? lastPageUrl;

  late int currentPage;
  late int lastPage;

  @override
  void initState() {
    super.initState();

    documentController =
        Provider.of<DocumentController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDocuments();
    });
  }

  Future<void> _fetchDocuments() async {
    try {
      DocumentPagination pagination = await documentController.getDocuments();

      if (!mounted) return;

      setState(() {
        documents = pagination.data;

        nextPageUrl = pagination.nextPageUrl;
        prevPageUrl = pagination.prevPageUrl;
        firstPageUrl = pagination.firstPageUrl;
        lastPageUrl = pagination.lastPageUrl;
        currentPage = pagination.currentPage;
        lastPage = pagination.lastPage;

        _isLoading = false;
      });
    } on TokenExpiredException catch (_) {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar documentos: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Document> _createDocument(
      String title, List<Tag> tags, String filePath) async {
    setState(() {
      _isLoading = true;
    });

    try {
      return await documentController.createDocument(title, tags, filePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create document: $e')),
      );
      rethrow;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleTap() {
    setState(() {
      _createDocumentButtonTapped = true;
    });

    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _createDocumentButtonTapped = false;
      });
    });
  }

  void _showForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DocumentCreationForm(
          onSubmit:
              (String documentTitle, List<Tag> tags, String? filePath) async {
            if (filePath != null) {
              Document document =
                  await _createDocument(documentTitle, tags, filePath);
              setState(() {
                documents.insert(0, document);
              });
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Documentos',
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                    ),
                    Expanded(child: DocumentGrid(documents: documents)),
                  ],
                ),
          Positioned(
            bottom: 16,
            right: 16,
            child: GestureDetector(
              onTap: _handleTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  color: _createDocumentButtonTapped
                      ? theme.colorScheme.surface
                      : theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: _showForm,
                  icon: Icon(Icons.add,
                      color: theme.colorScheme.surfaceContainerLowest),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
