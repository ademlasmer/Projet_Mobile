import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class PatientFormScreen extends StatelessWidget {
  const PatientFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouveau Patient')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Nom', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Prénom', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Date de naissance (JJ/MM/AAAA)', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Sexe', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'BMI', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Enregistrer',
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
