import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/buttons/default_button.dart';
import 'package:organize_ai_app/components/buttons/destructive_button.dart';
import 'package:organize_ai_app/components/tags/tag_controller.dart';
import 'package:organize_ai_app/components/tags/tag_selector.dart';
import 'package:organize_ai_app/exceptions/token_invalid_exception.dart';
import 'package:organize_ai_app/models/document.dart';
import 'package:organize_ai_app/models/tag.dart';
import 'package:organize_ai_app/models/tag_pagination.dart';
import 'package:organize_ai_app/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class UpdateDocumentScreen extends StatefulWidget {
  final bool isLoading;
  final Document document;
  final Function(String, List<Tag>) onSubmit;

  const UpdateDocumentScreen(
      {super.key,
      required this.document,
      required this.onSubmit,
      required this.isLoading});

  @override
  UpdateDocumentScreenState createState() => UpdateDocumentScreenState();
}

class UpdateDocumentScreenState extends State<UpdateDocumentScreen> {
  bool _areTagsLoading = true;

  late TextEditingController _titleController;

  late TagController tagController;
  late List<Tag> _selectedTags = [];
  late List<Tag> _availableTags = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.document.title);
    tagController = Provider.of<TagController>(context, listen: false);

    _selectedTags.addAll(widget.document.tags);

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
        _selectedTags = widget.document.tags.where((docTag) {
          return _availableTags
              .any((availableTag) => availableTag.id == docTag.id);
        }).toList();
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
        _areTagsLoading = false;
      });
    }
  }

  bool isTagSelected(Tag tag) {
    return _selectedTags.any((selectedTag) => selectedTag.id == tag.id);
  }

  void _onTagSelected(Tag tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atualizar documento"),
      ),
      body: widget.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("ID: ${widget.document.id}"),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Título'),
                  ),
                  const SizedBox(height: 16),
                  TagsSelector(
                    isLoading: _areTagsLoading,
                    availableTags: _availableTags,
                    selectedTags: _selectedTags,
                    onTagSelected: _onTagSelected,
                  ),
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
                          widget.onSubmit(_titleController.text, _selectedTags);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
