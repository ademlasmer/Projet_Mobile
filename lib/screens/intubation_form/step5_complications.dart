import 'package:flutter/material.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/custom_button.dart';
import 'step6_complementaires.dart';

class Step5Complications extends StatelessWidget {
  const Step5Complications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Étape 5 : Complications')),
      body: Column(
        children: [
          const StepIndicator(currentStep: 5),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                SwitchListTile(title: const Text('Intubation difficile (SFAR)'), value: false, onChanged: (v) {}),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(labelText: 'Complications (Champ libre)', border: OutlineInputBorder()),
                  maxLines: 4,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Suivant',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const Step6Complementaires()));
              },
            ),
          )
        ],
      ),
    );
  }
}
