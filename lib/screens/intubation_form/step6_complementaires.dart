import 'package:flutter/material.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/custom_button.dart';

class Step6Complementaires extends StatelessWidget {
  const Step6Complementaires({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Étape 6 : Complémentaires')),
      body: Column(
        children: [
          const StepIndicator(currentStep: 6),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Ajouter une photo'),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.mic),
                  label: const Text('Ajouter un mémo vocal (Optionnel)'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Terminer',
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/dashboard'));
              },
            ),
          )
        ],
      ),
    );
  }
}
