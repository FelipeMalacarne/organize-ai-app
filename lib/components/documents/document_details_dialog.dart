import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/buttons/default_button.dart';
import 'package:organize_ai_app/components/buttons/destructive_button.dart';
import 'package:organize_ai_app/components/tags/tag_selector.dart';
import 'package:organize_ai_app/models/document.dart';
import 'package:organize_ai_app/models/tag.dart';

class DocumentDetailsDialog extends StatefulWidget {
  final Document document;
  final Function(String, List<Tag>) onSubmit;

  const DocumentDetailsDialog(
      {super.key, required this.document, required this.onSubmit});

  @override
  DocumentDetailsDialogState createState() => DocumentDetailsDialogState();
}

class DocumentDetailsDialogState extends State<DocumentDetailsDialog> {
  bool _isLoading = true;

  late TextEditingController _titleController;
  final List<Tag> _selectedTags = [];
  final List<Map<String, String>> _availableTags = [
    {"id": "tag_jPMzLHRa3f", "name": "personal"},
    {"id": "tag_y3DZA3TguM", "name": "testefodase"},
    {"id": "tag_random1", "name": "work"},
    {"id": "tag_random2", "name": "urgent"},
  ]; // TODO: Replace with tags from an API or other source.

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.document.title);

    // Initialize selected tags from the document's existing tags
    // _selectedTags.addAll(widget.document.tags);

    _isLoading = false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Detalhes do documento"),
                      const SizedBox(height: 8),
                      Text("ID: ${widget.document.id}"),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Título'),
                      ),
                      const SizedBox(height: 16),
                      // TagsSelector(
                      //   availableTags: _availableTags,
                      //   selectedTags: _selectedTags,
                      //   onTagSelected: (tag) {
                      //     setState(() {
                      //       if (_selectedTags.contains(tag)) {
                      //         _selectedTags.remove(tag);
                      //       } else {
                      //         _selectedTags.add(tag);
                      //       }
                      //     });
                      //   },
                      // ),
                      const SizedBox(height: 16),
                      Text("File Type: ${widget.document.fileType}"),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DestructiveButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Cancelar',
                          ),
                          const SizedBox(width: 8),
                          DefaultButton(
                            text: "Salvar",
                            onPressed: () {
                              widget.onSubmit(
                                  _titleController.text, _selectedTags);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
      ],
    ));
  }
}
