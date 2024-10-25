import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/buttons/default_button.dart';
import 'package:organize_ai_app/components/buttons/destructive_button.dart';

class DocumentCreationForm extends StatefulWidget {
  final Function(String, List<String>, String?) onSubmit;

  const DocumentCreationForm({super.key, required this.onSubmit});

  @override
  DocumentCreationFormState createState() => DocumentCreationFormState();
}

class DocumentCreationFormState extends State<DocumentCreationForm> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _selectedTags = [];
  final List<String> _availableTags = [
    'Work',
    'Personal',
    'Fronks',
    'Flenks',
    'Flonks',
    'Splenks',
    'Splonks',
  ]; // TODO: Fetch from API
  String? _selectedFilePath;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFilePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _textController,
              decoration:
                  const InputDecoration(labelText: 'Enter document title'),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              children: _availableTags.map((tag) {
                return ChoiceChip(
                  label: Text(tag),
                  selected: _selectedTags.contains(tag),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickFile,
                  child: const Text('Select File'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _selectedFilePath != null
                        ? _selectedFilePath!
                        : 'No file selected',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DestructiveButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancel',
                ),
                DefaultButton(
                  onPressed: () {
                    widget.onSubmit(
                      _textController.text,
                      _selectedTags,
                      _selectedFilePath,
                    );
                    Navigator.pop(context);
                  },
                  text: 'Submit',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
