import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/documents/document_overview_page.dart';
import 'package:organize_ai_app/components/top_bar/side_drawer.dart';
import 'package:organize_ai_app/components/top_bar/top_bar.dart';
import 'package:organize_ai_app/mixins/requires_token.dart';
import 'package:organize_ai_app/models/user.dart';

class HomeScreen extends StatelessWidget with RequiresToken {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(
          onProfileTap: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        drawer: const SideDrawer(),
        body: const DocumentOverviewPage());
  }
}
