import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/buttons/default_button.dart';
import 'package:organize_ai_app/components/buttons/destructive_button.dart';
import 'package:organize_ai_app/components/tags/tag_controller.dart';
import 'package:organize_ai_app/components/tags/tag_selector.dart';
import 'package:organize_ai_app/exceptions/token_invalid_exception.dart';
import 'package:organize_ai_app/models/tag.dart';
import 'package:organize_ai_app/models/tag_pagination.dart';
import 'package:organize_ai_app/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class DocumentCreationForm extends StatefulWidget {
  final Function(String, List<Tag>, String?) onSubmit;

  const DocumentCreationForm({super.key, required this.onSubmit});

  @override
  DocumentCreationFormState createState() => DocumentCreationFormState();
}

class DocumentCreationFormState extends State<DocumentCreationForm> {
  bool _isLoading = true;

  late TagController tagController;
  late List<Tag> _selectedTags = [];
  late List<Tag> _availableTags = [];
  String? _selectedFilePath;

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    tagController = Provider.of<TagController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTags();
    });
  }

  Future<void> _fetchTags() async {
    try {
      TagPagination tagPagination = await tagController.getTags();

      if (!mounted) return;

      setState(() {
        _availableTags = tagPagination.data;
        _selectedTags = [];
      });
    } catch (error) {
      if (error is TokenExpiredException) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao buscar tags: $error')));
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
            TagsSelector(
              isLoading: _isLoading,
              availableTags: _availableTags,
              selectedTags: _selectedTags,
              onTagSelected: (tag) {
                setState(() {
                  if (_selectedTags.contains(tag)) {
                    _selectedTags.remove(tag);
                  } else {
                    _selectedTags.add(tag);
                  }
                });
              },
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
