import 'dart:async';
import 'package:flutter/material.dart';
import 'package:organize_ai_app/models/document.dart';
import 'package:organize_ai_app/screens/document/document_controller.dart';
import 'package:organize_ai_app/screens/document/detailed_document_screen.dart';
import 'package:provider/provider.dart';

class DocumentTile extends StatefulWidget {
  final Document document;

  const DocumentTile({super.key, required this.document});

  @override
  DocumentTileState createState() => DocumentTileState();
}

class DocumentTileState extends State<DocumentTile> {
  late Document document;
  late DocumentController documentController;
  bool _tapped = false;

  @override
  void initState() {
    super.initState();

    document = widget.document;

    documentController =
        Provider.of<DocumentController>(context, listen: false);
  }

  void _handleTap() {
    setState(() {
      _tapped = true;
    });

    Timer(const Duration(milliseconds: 200), () {
      setState(() {
        _tapped = false;
      });
      _showDocumentScreen(context);
    });
  }

  void _showDocumentScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedDocumentScreen(
          document: document,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Icon? icon;
    double iconSize = 60.0;
    Color iconColor = theme.colorScheme.surfaceContainerHighest;

    switch (document.fileType) {
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
            Text(document.title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
