import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/intubation_provider.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/custom_button.dart';
import 'step6_complementaires.dart';

class Step5Complications extends StatelessWidget {
  const Step5Complications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Étape 5 : Complications')),
      body: Consumer<IntubationProvider>(
        builder: (context, provider, child) {
          final intub = provider.currentIntubation;
          if (intub == null) return const Center(child: CircularProgressIndicator());

          return Column(
            children: [
              const StepIndicator(currentStep: 5),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    SwitchListTile(
                      title: const Text('Intubation difficile (SFAR)'), 
                      value: intub.intubationDifficile, 
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(intubationDifficile: v));
                      }
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: intub.complicationsLibres ?? '',
                      decoration: const InputDecoration(labelText: 'Complications (Champ libre)', border: OutlineInputBorder()),
                      maxLines: 4,
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(complicationsLibres: v));
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
                    provider.setStep(6);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const Step6Complementaires()));
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
