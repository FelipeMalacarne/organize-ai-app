import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organize_ai_app/components/documents/document_controller.dart';
import 'package:organize_ai_app/components/tags/tag_controller.dart';
import 'package:organize_ai_app/config/dark_theme.dart';
import 'package:organize_ai_app/config/light_theme.dart';
import 'package:organize_ai_app/providers/theme_provider.dart';
import 'package:organize_ai_app/screens/auth/content_screen.dart';
import 'package:organize_ai_app/screens/auth/user_controller.dart';
import 'package:organize_ai_app/screens/login/login_controller.dart';
import 'package:organize_ai_app/screens/register/register_controller.dart';
import 'package:organize_ai_app/services/auth_service.dart';
import 'package:organize_ai_app/services/document_service.dart';
import 'package:organize_ai_app/services/tag_service.dart';
import 'package:organize_ai_app/services/user_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginController(AuthService()),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterController(AuthService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(create: (_) => UserController(UserService())),
        ChangeNotifierProvider(
            create: (_) => DocumentController(DocumentService())),
        ChangeNotifierProvider(create: (_) => TagController(TagService())),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: AppLightTheme.themeData,
            darkTheme: AppDarkTheme.themeData,
            themeMode: themeProvider.themeMode,
            home: const AuthScreen(),
          );
        },
      ),
    );
  }
}
