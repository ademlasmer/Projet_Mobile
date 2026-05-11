import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Mot de passe', border: OutlineInputBorder()),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'S\'inscrire',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
