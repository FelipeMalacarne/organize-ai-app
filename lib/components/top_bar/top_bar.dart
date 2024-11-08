import 'package:flutter/material.dart';

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

    return AppBar(
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      title: _isSearching
          ? TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search documents...',
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                widget.onSearch(value);
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
