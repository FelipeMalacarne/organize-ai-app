import 'package:flutter/material.dart';
import 'package:organize_ai_app/providers/document_provider.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onProfileTap;
  final ValueChanged<String> onSearch;

  const TopBar({super.key, required this.onProfileTap, required this.onSearch});

  @override
  TopBarState createState() => TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class TopBarState extends State<TopBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final documentProvider =
        Provider.of<DocumentProvider>(context, listen: false);

    return AppBar(
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      title: _isSearching
          ? TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search documents...',
                border: InputBorder.none,
              ),
              onSubmitted: (value) async {
                documentProvider.setLoading(true);
                widget.onSearch(value);
                documentProvider.setLoading(false);
              },
            )
          : null,
      actions: [
        IconButton(
          onPressed: () {
            if (_isSearching) {
              widget.onSearch(_searchController.text);
            } else {
              setState(() {
                _isSearching = true;
              });
            }
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
