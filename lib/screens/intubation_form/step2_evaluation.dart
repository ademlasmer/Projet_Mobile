import 'package:flutter/material.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/custom_button.dart';
import 'step3_risque.dart';

class Step2Evaluation extends StatelessWidget {
  const Step2Evaluation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Étape 2 : Évaluation')),
      body: Column(
        children: [
          const StepIndicator(currentStep: 2),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: 'Score ASA', border: OutlineInputBorder()),
                  items: [1, 2, 3, 4, 5, 6].map((e) => DropdownMenuItem(value: e, child: Text('ASA $e'))).toList(),
                  onChanged: (v) {},
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Mallampati', border: OutlineInputBorder()),
                  items: ['I', 'II', 'III', 'IV'].map((e) => DropdownMenuItem(value: e, child: Text('Classe $e'))).toList(),
                  onChanged: (v) {},
                ),
                // Other fields... DTM, ouverture buccale
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Suivant',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const Step3Risque()));
              },
            ),
          )
        ],
      ),
    );
  }
}
