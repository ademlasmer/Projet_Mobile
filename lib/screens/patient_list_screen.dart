import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';
import '../widgets/patient_card.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Patients'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un patient...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                filled: true,
                fillColor: Colors.grey[850],
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: patientProvider.patients.length,
        itemBuilder: (context, index) {
          final patient = patientProvider.patients[index];
          return PatientCard(
            patient: patient,
            onTap: () {
              // Action when tapped
            },
          );
        },
      ),
    );
  }
}
