import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentTile extends StatelessWidget {
  final Map<String, String> document;

  const DocumentTile({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String? icon;

    switch (document['type']) {
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
