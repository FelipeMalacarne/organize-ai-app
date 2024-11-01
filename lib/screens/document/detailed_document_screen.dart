import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/buttons/default_button.dart';
import 'package:organize_ai_app/components/buttons/destructive_button.dart';
import 'package:organize_ai_app/inputs/update_document_input.dart';
import 'package:organize_ai_app/models/document.dart';
import 'package:organize_ai_app/models/tag.dart';
import 'package:organize_ai_app/screens/document/document_controller.dart';
import 'package:organize_ai_app/screens/document/update_document_screen.dart';
import 'package:provider/provider.dart';

class DetailedDocumentScreen extends StatefulWidget {
  final Document document;

  const DetailedDocumentScreen({super.key, required this.document});

  @override
  DetailedDocumentScreenState createState() => DetailedDocumentScreenState();
}

class DetailedDocumentScreenState extends State<DetailedDocumentScreen> {
  late Document document;
  late DocumentController documentController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    document = widget.document;

    documentController =
        Provider.of<DocumentController>(context, listen: false);
  }

  void _showUpdateDocumentScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateDocumentScreen(
          isLoading: _isLoading,
          document: document,
          onSubmit: (updatedTitle, updatedTags) async {
            _isLoading = true;
            Document updatedDocument =
                await _updateDocument(updatedTitle, updatedTags);
            setState(() {
              document = updatedDocument;
            });
            _isLoading = false;
          },
        ),
      ),
    );
  }

  Future<Document> _updateDocument(String title, List<Tag> tags) async {
    setState(() {
      _isLoading = true;
    });

    UpdateDocumentInput input = UpdateDocumentInput(
      title: title,
      tags: tags,
    );

    try {
      return await documentController.updateDocument(document.id, input);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar documento: $e')),
      );
      return document;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteDocument() async {
    try {
      await documentController.deleteDocument(document.id);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir documento: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title: ${document.title}",
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "File Type: ${document.fileType}",
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Tags:",
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: document.tags.map((tag) {
                      return Chip(
                        label: Text(tag.name),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Metadata:",
                  ),
                  const SizedBox(height: 8.0),
                  document.metadata.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: document.metadata.map((meta) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                meta.toString(),
                              ),
                            );
                          }).toList(),
                        )
                      : const Text(
                          "No metadata available.",
                        ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DestructiveButton(
                        text: "Excluir",
                        onPressed: () {
                          _deleteDocument();

                          Navigator.pop(context);
                        },
                      ),
                      DefaultButton(
                        text: "Editar",
                        onPressed: () {
                          _showUpdateDocumentScreen(context);
                        },
                      )
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
