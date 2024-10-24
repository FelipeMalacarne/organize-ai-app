import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/buttons/link_button.dart';
import 'package:organize_ai_app/models/user.dart';
import 'package:organize_ai_app/screens/auth/user_controller.dart';
import 'package:organize_ai_app/screens/register/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:organize_ai_app/components/buttons/default_button.dart';
import 'package:organize_ai_app/screens/login/login_controller.dart';
import 'package:organize_ai_app/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    final userController = Provider.of<UserController>(context);

    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 450.0,
              child: TextField(
                controller: loginController.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 450.0,
              child: TextField(
                controller: loginController.passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 30),
            DefaultButton(
              text: 'Login',
              onPressed: () async {
                await loginController.login();

                if (loginController.errorMessage.isEmpty) {
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
            LinkButton(
                text: 'Ainda não está cadastrado? Cadastre-se aqui.',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                }),
            const SizedBox(height: 30),
            if (loginController.isLoading) const CircularProgressIndicator(),
            if (loginController.errorMessage.isNotEmpty)
              SizedBox(
                child: Text(
                  loginController.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    ));
  }
}
