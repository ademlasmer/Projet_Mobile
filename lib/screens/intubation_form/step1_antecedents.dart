import 'package:flutter/material.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/custom_button.dart';
import 'step2_evaluation.dart';

class Step1Antecedents extends StatelessWidget {
  const Step1Antecedents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Étape 1 : Antécédents')),
      body: Column(
        children: [
          const StepIndicator(currentStep: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                SwitchListTile(title: const Text('SAOS'), value: false, onChanged: (v) {}),
                SwitchListTile(title: const Text('Diabète'), value: false, onChanged: (v) {}),
                SwitchListTile(title: const Text('Goitre'), value: false, onChanged: (v) {}),
                const TextField(
                  decoration: InputDecoration(labelText: 'Autres antécédents', border: OutlineInputBorder()),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Suivant',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const Step2Evaluation()));
              },
            ),
          )
        ],
      ),
    );
  }
}
