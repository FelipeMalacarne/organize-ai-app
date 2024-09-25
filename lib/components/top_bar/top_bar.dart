import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onProfileTap;

  const TopBar({super.key, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      title: const Text("Home"),
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
