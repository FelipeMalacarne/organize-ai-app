import 'package:flutter/material.dart';
import 'package:organize_ai_app/models/tag.dart';

class TagsSelector extends StatelessWidget {
  final bool isLoading;
  final List<Tag> availableTags;
  final List<Tag> selectedTags;
  final Function(Tag) onTagSelected;

  const TagsSelector({
    super.key,
    required this.availableTags,
    required this.selectedTags,
    required this.onTagSelected,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: availableTags
                        .sublist(0, (availableTags.length / 2).ceil())
                        .map((tag) {
                      final isSelected = selectedTags.contains(tag);
                      return ChoiceChip(
                        label: Text(tag.name),
                        selected: isSelected,
                        onSelected: (_) => onTagSelected(tag),
                      );
                    }).toList(),
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: availableTags
                        .sublist((availableTags.length / 2).ceil())
                        .map((tag) {
                      final isSelected = selectedTags.contains(tag);
                      return ChoiceChip(
                        label: Text(tag.name),
                        selected: isSelected,
                        onSelected: (_) => onTagSelected(tag),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
  }
}
