import 'package:flutter/material.dart';
import 'package:organize_ai_app/services/auth_service.dart';
import 'package:organize_ai_app/services/secure_storage_service.dart';

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
        await SecureStorageService().save(token);
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
