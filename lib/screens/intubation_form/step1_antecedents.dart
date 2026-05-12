import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/intubation_provider.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/custom_button.dart';
import 'step2_evaluation.dart';

class Step1Antecedents extends StatelessWidget {
  const Step1Antecedents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Étape 1 : Antécédents')),
      body: Consumer<IntubationProvider>(
        builder: (context, provider, child) {
          final intub = provider.currentIntubation;
          if (intub == null) return const Center(child: CircularProgressIndicator());
          
          return Column(
            children: [
              const StepIndicator(currentStep: 1),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    SwitchListTile(
                      title: const Text('SAOS'), 
                      value: intub.saos, 
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(saos: v));
                      }
                    ),
                    SwitchListTile(
                      title: const Text('Diabète'), 
                      value: intub.diabete, 
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(diabete: v));
                      }
                    ),
                    SwitchListTile(
                      title: const Text('Goitre'), 
                      value: intub.goitre, 
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(goitre: v));
                      }
                    ),
                    TextFormField(
                      initialValue: intub.antecedents ?? '',
                      decoration: const InputDecoration(labelText: 'Autres antécédents', border: OutlineInputBorder()),
                      maxLines: 3,
                      onChanged: (v) {
                        provider.updateIntubation(intub.copyWith(antecedents: v));
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
                    provider.setStep(2);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const Step2Evaluation()));
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
