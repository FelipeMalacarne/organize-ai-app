import 'dart:async';

import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/documents/document_creation_form.dart';
import 'package:organize_ai_app/components/documents/document_grid.dart';

class DocumentOverviewPage extends StatefulWidget {
  const DocumentOverviewPage({super.key});

  @override
  DocumentOverviewState createState() => DocumentOverviewState();
}

class DocumentOverviewState extends State<DocumentOverviewPage> {
  bool _isLoading = true;

  bool _createDocumentButtonTapped = false;

  // Dummy data
  final List<Map<String, String>> _documents = [
    {'name': 'Document 1', 'type': 'pdf'},
    {'name': 'Document 2', 'type': 'pdf'},
    {'name': 'Document 3', 'type': 'jpeg'},
    {'name': 'Document 4', 'type': 'jpg'},
    {'name': 'Document 5', 'type': 'docx'},
  ];

  @override
  void initState() {
    super.initState();

    // TODO: Perform document and user get
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
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
                    Expanded(child: DocumentGrid(documents: _documents)),
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
              (String documentTitle, List<String> tags, String? description) {
            setState(() {
              // TODO: Add the created doc with title, tags, and description
            });
          },
        );
      },
    );
  }
}
