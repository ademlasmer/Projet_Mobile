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
  String _sexe = 'M';
  final TextEditingController _bmiController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _dateController.dispose();
    _bmiController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.teal,
              onPrimary: Colors.white,
              surface: Color(0xFF1E1E1E),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF121212),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _savePatient() {
    if (_formKey.currentState!.validate()) {
      final patient = Patient(
        nom: _nomController.text,
        prenom: _prenomController.text,
        sexe: _sexe,
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
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: const InputDecoration(
                  labelText: 'Date de naissance (AAAA-MM-JJ)', 
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ce champ est requis';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _sexe,
                decoration: const InputDecoration(labelText: 'Sexe', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'M', child: Text('Masculin (M)')),
                  DropdownMenuItem(value: 'F', child: Text('Féminin (F)')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _sexe = value;
                    });
                  }
                },
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
