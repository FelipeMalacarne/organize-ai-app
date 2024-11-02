import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/json_visualizer.dart';
import 'package:organize_ai_app/models/extraction.dart';

class DocumentExtractions extends StatelessWidget {
  final List<Extraction> extractions;

  const DocumentExtractions({super.key, required this.extractions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Extrações",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        extractions.isEmpty
            ? const Text("Nenhuma extração disponível.")
            : Column(
                children: extractions.map((extraction) {
                  return ExpansionTile(
                    title: Text("Tipo: ${extraction.type}"),
                    subtitle: Text("Data: ${extraction.createdAt.toLocal()}"),
                    children: [
                      if (extraction.extractedText != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Texto Extraído: ${extraction.extractedText}",
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      if (extraction.extractedJson != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: JsonVisualizer(json: extraction.extractedJson),
                        ),
                    ],
                  );
                }).toList(),
              ),
      ],
    );
  }
}
