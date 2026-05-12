import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/intubation_provider.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/custom_button.dart';
import 'step5_complications.dart';

class Step4PerIntub extends StatelessWidget {
  const Step4PerIntub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Étape 4 : Per-intubation')),
      body: Consumer<IntubationProvider>(
        builder: (context, provider, child) {
          final intub = provider.currentIntubation;
          if (intub == null) return const Center(child: CircularProgressIndicator());

          return Column(
            children: [
              const StepIndicator(currentStep: 4),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    TextFormField(
                      initialValue: intub.typeIntubation ?? '',
                      decoration: const InputDecoration(labelText: 'Type d\'intubation', border: OutlineInputBorder()),
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(typeIntubation: v));
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: intub.tentatives?.toString() ?? '',
                      decoration: const InputDecoration(labelText: 'Nombre de tentatives', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(tentatives: int.tryParse(v)));
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Vidéo-laryngoscope utilisé'), 
                      value: intub.utiliseVideoLaryngoscope, 
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(utiliseVideoLaryngoscope: v));
                      }
                    ),
                    DropdownButtonFormField<int>(
                      value: intub.scoreCormack,
                      decoration: const InputDecoration(labelText: 'Score Cormack', border: OutlineInputBorder()),
                      items: [1, 2, 3, 4].map((e) => DropdownMenuItem(value: e, child: Text('Grade $e'))).toList(),
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(scoreCormack: v));
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  text: 'Suivant',
                  onPressed: () {
                    provider.setStep(5);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const Step5Complications()));
                  },
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
