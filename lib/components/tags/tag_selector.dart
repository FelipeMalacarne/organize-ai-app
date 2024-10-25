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

  bool isTagSelected(Tag tag) {
    return selectedTags.any((selectedTag) => selectedTag.id == tag.id);
  }

  @override
  Widget build(BuildContext context) {
    final selectedTagsList = availableTags.where(isTagSelected).toList();
    final unselectedTagsList =
        availableTags.where((tag) => !isTagSelected(tag)).toList();

    final firstWrapTags = [
      ...selectedTagsList.sublist(0, (selectedTagsList.length / 2).ceil()),
      ...unselectedTagsList.sublist(0, (unselectedTagsList.length / 2).ceil())
    ];

    final secondWrapTags = [
      ...selectedTagsList.sublist((selectedTagsList.length / 2).ceil()),
      ...unselectedTagsList.sublist((unselectedTagsList.length / 2).ceil())
    ];

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
                    children: firstWrapTags.map((tag) {
                      final isSelected = isTagSelected(tag);
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
                    children: secondWrapTags.map((tag) {
                      final isSelected = isTagSelected(tag);
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
