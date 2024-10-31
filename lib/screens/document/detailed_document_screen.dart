import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/buttons/default_button.dart';
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
            Document updatedDocument =
                await _updateDocument(updatedTitle, updatedTags);
            setState(() {
              document = updatedDocument;
            });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do documento"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DefaultButton(
              text: "Editar",
              onPressed: () {
                _showUpdateDocumentScreen(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
