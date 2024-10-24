import 'dart:async';
import 'package:flutter/material.dart';

class DocumentTile extends StatefulWidget {
  final Map<String, String> document;

  const DocumentTile({super.key, required this.document});

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
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Icon? icon;
    double iconSize = 60.0;
    Color iconColor = theme.colorScheme.surfaceContainerHighest;

    switch (widget.document['type']) {
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
            Text(widget.document['name']!,
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
