import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/auth_service.dart';

class LoginController with ChangeNotifier {
  final AuthService authService;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  LoginController(this.authService);

  Future<void> login() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final email = emailController.text;
      final password = passwordController.text;

      final token = await authService.login(email, password);
      if (token.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('organize_ai_token', token);
        notifyListeners();
      }
    } catch (error) {
      _errorMessage = 'Login failed: ${error.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
