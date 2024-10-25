import 'dart:async';
import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/documents/document_details_dialog.dart';
import 'package:organize_ai_app/models/document.dart';
import 'package:organize_ai_app/screens/document/document_controller.dart';

class DocumentTile extends StatefulWidget {
  Document document;

  late DocumentController documentController;

  DocumentTile({super.key, required this.document});

  @override
  DocumentTileState createState() => DocumentTileState();
}

class DocumentTileState extends State<DocumentTile> {
  bool _tapped = false;

  void _handleTap() {
    setState(() {
      _tapped = true;
    });

    Timer(const Duration(milliseconds: 200), () {
      setState(() {
        _tapped = false;
      });
      _showDocumentDialog(context);
    });
  }

  void _showDocumentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DocumentDetailsDialog(
          document: widget.document,
          onSubmit: (updatedTitle, updatedTags) {
            setState(() {
              widget.document.title = updatedTitle;
              widget.document.tags = updatedTags;
            });
          },
        );
      },
    );
  }

  // Future<Document> _updateDocument(String title, List<String> tags) async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     return await documentController.createDocument(title, tags, filePath);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to create document: $e')),
  //     );
  //     rethrow;
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Icon? icon;
    double iconSize = 60.0;
    Color iconColor = theme.colorScheme.surfaceContainerHighest;

    switch (widget.document.fileType) {
      case 'pdf':
        icon = Icon(
          Icons.picture_as_pdf,
          size: iconSize,
          color: iconColor,
        );
        break;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'tiff':
        icon = Icon(
          Icons.image,
          size: iconSize,
          color: iconColor,
        );
        break;
      default:
        icon = Icon(
          Icons.insert_drive_file,
          size: iconSize,
          color: iconColor,
        );
        break;
    }

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: _tapped
            ? theme.colorScheme.surfaceContainerLowest
            : theme.colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 20),
            Text(widget.document.title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
