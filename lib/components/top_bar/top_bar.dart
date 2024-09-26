import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onProfileTap;

  const TopBar({super.key, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      actions: [
        IconButton(
          onPressed: onProfileTap,
          icon: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/default_user.jpeg')),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
