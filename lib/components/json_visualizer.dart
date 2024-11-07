import 'package:flutter/material.dart';

class JsonVisualizer extends StatelessWidget {
  final dynamic json;

  const JsonVisualizer({super.key, required this.json});

  @override
  Widget build(BuildContext context) {
    if (json is Map<String, dynamic>) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (json as Map<String, dynamic>).entries.map((entry) {
          return entry.value is Map || entry.value is List
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${entry.key}:"),
                      JsonVisualizer(json: entry.value),
                    ],
                  ),
                )
              : Text("${entry.key}: ${entry.value}");
        }).toList(),
      );
    } else if (json is List) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (json as List).map((item) {
          return item is Map || item is List
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: JsonVisualizer(json: item),
                )
              : Text(item.toString());
        }).toList(),
      );
    } else {
      return Text(json.toString());
    }
  }
}
