import 'dart:async';
import 'package:flutter/material.dart';
import 'package:organize_ai_app/providers/document_provider.dart';
import 'package:organize_ai_app/components/documents/document_creation_form.dart';
import 'package:organize_ai_app/components/documents/document_grid.dart';
import 'package:organize_ai_app/models/document.dart';
import 'package:organize_ai_app/models/tag.dart';
import 'package:provider/provider.dart';

class DocumentOverviewPage extends StatefulWidget {
  const DocumentOverviewPage({super.key});

  @override
  DocumentOverviewState createState() => DocumentOverviewState();
}

class DocumentOverviewState extends State<DocumentOverviewPage> {
  bool _isLoading = true;
  bool _createDocumentButtonTapped = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDocuments();
    });
  }

  Future<void> _fetchDocuments() async {
    final documentProvider =
        Provider.of<DocumentProvider>(context, listen: false);
    try {
      await documentProvider.fetchDocuments();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
              final documentProvider =
                  Provider.of<DocumentProvider>(context, listen: false);
              Document document = await documentProvider.createDocument(
                  documentTitle, tags, filePath);
              setState(() {
                documentProvider.documents.insert(0, document);
              });
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final documentProvider = Provider.of<DocumentProvider>(context);
    final theme = Theme.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (documentProvider.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${documentProvider.errorMessage}')),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: _fetchDocuments,
                  child: Column(
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
                      Expanded(
                          child: DocumentGrid(
                              documents: documentProvider.documents)),
                    ],
                  ),
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
