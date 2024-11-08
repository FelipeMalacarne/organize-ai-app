import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/documents/document_overview_page.dart';
import 'package:organize_ai_app/components/top_bar/side_drawer.dart';
import 'package:organize_ai_app/components/top_bar/top_bar.dart';
import 'package:organize_ai_app/mixins/requires_token.dart';
import 'package:organize_ai_app/models/user.dart';
import 'package:organize_ai_app/providers/document_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget with RequiresToken {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  void _handleSearch(String query) {
    Provider.of<DocumentProvider>(context, listen: false)
        .fetchDocuments(search: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        onProfileTap: () {
          Scaffold.of(context).openDrawer();
        },
        onSearch: _handleSearch,
      ),
      drawer: const SideDrawer(),
      body: Builder(
        builder: (BuildContext context) {
          return DocumentOverviewPage();
        },
      ),
    );
  }
}
