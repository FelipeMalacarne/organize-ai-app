import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    String? icon;

    switch (widget.document['type']) {
      case 'pdf':
        icon = 'assets/icons/pdf.svg';
        break;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'tiff':
        icon = 'assets/icons/image.svg';
        break;
      default:
        icon = 'assets/icons/unknown.svg';
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
            SvgPicture.asset(
              icon,
              width: 60,
              height: 60,
              color: theme.colorScheme.surfaceContainerHighest,
              placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
            ),
            const SizedBox(height: 20),
            Text(widget.document['name']!,
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
