import 'package:flutter/material.dart';
import 'package:organize_ai_app/components/buttons/link_button.dart';
import 'package:organize_ai_app/screens/register/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:organize_ai_app/components/buttons/default_button.dart';
import 'package:organize_ai_app/screens/login/login_controller.dart';
import 'package:organize_ai_app/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);

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
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 450.0,
              child: TextField(
                controller: controller.passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 30),
            DefaultButton(
              text: 'Login',
              onPressed: () {
                controller.login();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
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
            if (controller.isLoading) const CircularProgressIndicator(),
            if (controller.errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  controller.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    ));
  }
}
