import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/documents/document_tile.dart';

class DocumentGrid extends StatelessWidget {
  final List<Map<String, String>> documents;

  const DocumentGrid({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1,
        ),
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return DocumentTile(document: documents[index]);
        },
      ),
    );
  }
}
