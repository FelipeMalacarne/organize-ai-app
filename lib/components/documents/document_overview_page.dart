import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      appBar: AppBar(
        title: const Text('Documentos'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildDocumentGrid(),
    );
  }

  Widget _buildDocumentGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1,
        ),
        itemCount: _documents.length,
        itemBuilder: (context, index) {
          final document = _documents[index];
          return _buildDocumentTile(document);
        },
      ),
    );
  }

  Widget _buildDocumentTile(Map<String, String> document) {
    final theme = Theme.of(context);
    String? icon;

    switch (document['type']) {
      case 'pdf':
        icon = 'assets/icons/pdf.svg';
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'tiff':
        icon = 'assets/icons/image.svg';
      default:
        icon = 'assets/icons/unknown.svg';
    }

    return Card(
      elevation: 2.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 60,
            height: 60,
            color: theme.colorScheme.surfaceContainerHighest,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
          ),
          const SizedBox(height: 20),
          Text(document['name']!, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
