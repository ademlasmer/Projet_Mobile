import 'package:flutter/material.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/custom_button.dart';
import 'step4_per_intub.dart';

class Step3Risque extends StatelessWidget {
  const Step3Risque({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Étape 3 : Risque')),
      body: Column(
        children: [
          const StepIndicator(currentStep: 3),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Intubation prévue', border: OutlineInputBorder()),
                  items: ['Facile', 'Difficile'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Suivant',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const Step4PerIntub()));
              },
            ),
          )
        ],
      ),
    );
  }
}
