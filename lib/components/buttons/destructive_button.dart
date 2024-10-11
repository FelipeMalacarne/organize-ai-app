import 'package:flutter/material.dart';

class DestructiveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DestructiveButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
