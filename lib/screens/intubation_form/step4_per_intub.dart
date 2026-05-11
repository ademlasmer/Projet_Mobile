import 'package:flutter/material.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/custom_button.dart';
import 'step5_complications.dart';

class Step4PerIntub extends StatelessWidget {
  const Step4PerIntub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Étape 4 : Per-intubation')),
      body: Column(
        children: [
          const StepIndicator(currentStep: 4),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const TextField(decoration: InputDecoration(labelText: 'Type d\'intubation', border: OutlineInputBorder())),
                const SizedBox(height: 16),
                const TextField(decoration: InputDecoration(labelText: 'Nombre de tentatives', border: OutlineInputBorder()), keyboardType: TextInputType.number),
                SwitchListTile(title: const Text('Vidéo-laryngoscope utilisé'), value: false, onChanged: (v) {}),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: 'Score Cormack', border: OutlineInputBorder()),
                  items: [1, 2, 3, 4].map((e) => DropdownMenuItem(value: e, child: Text('Grade $e'))).toList(),
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
                Navigator.push(context, MaterialPageRoute(builder: (_) => const Step5Complications()));
              },
            ),
          )
        ],
      ),
    );
  }
}
