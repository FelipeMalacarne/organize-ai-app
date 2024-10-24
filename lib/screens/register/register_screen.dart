import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/buttons/default_button.dart';
import 'package:organize_ai_app/models/user.dart';
import 'package:organize_ai_app/screens/auth/user_controller.dart';
import 'package:organize_ai_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:organize_ai_app/screens/register/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController registerController =
        Provider.of<RegisterController>(context);
    final UserController userController = Provider.of<UserController>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: registerController.nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: registerController.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: registerController.passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: registerController.passwordConfirmationController,
              decoration:
                  const InputDecoration(labelText: 'Confirmação de Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            DefaultButton(
              text: 'Registrar',
              onPressed: () async {
                await registerController.register();

                if (registerController.errorMessage.isEmpty) {
                  User user = await userController.getCurrentUser();

                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                user: user,
                              )),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 30),
            if (registerController.isLoading) const CircularProgressIndicator(),
            if (registerController.errorMessage.isNotEmpty)
              SizedBox(
                child: Text(
                  registerController.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
