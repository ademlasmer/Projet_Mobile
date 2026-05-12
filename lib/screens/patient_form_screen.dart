import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';
import '../providers/patient_provider.dart';
import '../models/patient.dart';

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({Key? key}) : super(key: key);

  @override
  _PatientFormScreenState createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _sexeController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();

  void _savePatient() {
    if (_formKey.currentState!.validate()) {
      final patient = Patient(
        nom: _nomController.text,
        prenom: _prenomController.text,
        sexe: _sexeController.text.isNotEmpty ? _sexeController.text : 'M',
        dateNaissance: DateTime.tryParse(_dateController.text) ?? DateTime.now(),
        bmi: double.tryParse(_bmiController.text) ?? 20.0,
      );

      Provider.of<PatientProvider>(context, listen: false).addPatient(patient);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouveau Patient')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomController, 
                decoration: const InputDecoration(labelText: 'Nom', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Ce champ est requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _prenomController, 
                decoration: const InputDecoration(labelText: 'Prénom', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Ce champ est requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController, 
                decoration: const InputDecoration(labelText: 'Date de naissance (AAAA-MM-JJ)', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ce champ est requis';
                  if (DateTime.tryParse(value) == null) return 'Format invalide (AAAA-MM-JJ)';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sexeController, 
                decoration: const InputDecoration(labelText: 'Sexe (M/F)', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Ce champ est requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bmiController, 
                decoration: const InputDecoration(labelText: 'BMI', border: OutlineInputBorder()), 
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ce champ est requis';
                  if (double.tryParse(value) == null) return 'Doit être un nombre valide';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Enregistrer',
                onPressed: _savePatient,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
