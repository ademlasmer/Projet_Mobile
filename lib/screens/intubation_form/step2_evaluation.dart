import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/intubation_provider.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/custom_button.dart';
import 'step3_risque.dart';

class Step2Evaluation extends StatelessWidget {
  const Step2Evaluation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Étape 2 : Évaluation')),
      body: Consumer<IntubationProvider>(
        builder: (context, provider, child) {
          final intub = provider.currentIntubation;
          if (intub == null) return const Center(child: CircularProgressIndicator());

          return Column(
            children: [
              const StepIndicator(currentStep: 2),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    DropdownButtonFormField<int>(
                      value: intub.scoreAsa,
                      decoration: const InputDecoration(labelText: 'Score ASA', border: OutlineInputBorder()),
                      items: [1, 2, 3, 4, 5, 6].map((e) => DropdownMenuItem(value: e, child: Text('ASA $e'))).toList(),
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(scoreAsa: v));
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: intub.mallampati,
                      decoration: const InputDecoration(labelText: 'Mallampati', border: OutlineInputBorder()),
                      items: ['I', 'II', 'III', 'IV'].map((e) => DropdownMenuItem(value: e, child: Text('Classe $e'))).toList(),
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(mallampati: v));
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: intub.dtm,
                      decoration: const InputDecoration(labelText: 'Distance Thyro-Mentonnière', border: OutlineInputBorder()),
                      items: ['< 65 mm', '>= 65 mm'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(dtm: v));
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: intub.ouvertureBuccale,
                      decoration: const InputDecoration(labelText: 'Ouverture Buccale', border: OutlineInputBorder()),
                      items: ['< 35 mm', '>= 35 mm'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(ouvertureBuccale: v));
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
                    provider.setStep(3);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const Step3Risque()));
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
