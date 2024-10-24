import 'package:flutter/material.dart';
import 'package:organize_ai_app/mixins/requires_token.dart';
import 'package:organize_ai_app/models/user.dart';
import 'package:organize_ai_app/screens/auth/user_controller.dart';
import 'package:organize_ai_app/screens/login/login_screen.dart';
import 'package:organize_ai_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget with RequiresToken {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  late UserController controller;

  @override
  void initState() {
    super.initState();
    _checkToken();

    controller = Provider.of<UserController>(context, listen: false);
  }

  Future<void> _checkToken() async {
    final token = await widget.getToken();

    if (token == null) {
      _redirectToLogin();
    } else {
      final user = await _getCurrentUser(token);
      if (user == null) {
        _redirectToLogin();
      } else {
        _redirectToHome(user);
      }
    }
  }

  Future<void> _redirectToLogin() async {
    widget.deleteToken();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Future<void> _redirectToHome(User user) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
    );
  }

  Future<User?> _getCurrentUser(String token) async {
    User? user;

    try {
      user = await controller.getCurrentUser();
    } catch (error) {
      _redirectToLogin();

      return null;
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
