import 'package:flutter/material.dart';
import 'package:organize_ai_app/services/auth_service.dart';
import 'package:organize_ai_app/services/secure_storage_service.dart';

class RegisterController with ChangeNotifier {
  final AuthService authService;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  RegisterController(this.authService);

  Future<void> register() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final name = nameController.text;
      final email = emailController.text;
      final password = passwordController.text;
      final passwordConfirmation = passwordConfirmationController.text;

      if (password != passwordConfirmation) {
        throw 'As senhas não coincidem.';
      }

      final token = await authService.register(
          name, email, password, passwordConfirmation);
      if (token.isNotEmpty) {
        await SecureStorageService().save(token);
      }
    } catch (error) {
      _errorMessage = 'Erro no registro: ${error.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }
}
