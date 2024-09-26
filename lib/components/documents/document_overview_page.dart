import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/documents/document_grid.dart';

class DocumentOverviewPage extends StatefulWidget {
  const DocumentOverviewPage({super.key});

  @override
  DocumentOverviewState createState() => DocumentOverviewState();
}

class DocumentOverviewState extends State<DocumentOverviewPage> {
  bool _isLoading = true;

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

    // Perform document and user get
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
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
    );
  }
}
