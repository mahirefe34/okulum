import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<AuthService>()
                  .createUserWithEmailAndPasswordAndContext(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    context: context,
                  );
              Navigator.pop(context);
            },
            child: const Text('Register'),
          )
        ],
      ),
    );
  }
}
