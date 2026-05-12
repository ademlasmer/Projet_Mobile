import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import '../providers/patient_provider.dart';
import '../providers/intubation_provider.dart';
import '../widgets/patient_card.dart';
import '../services/pdf_service.dart';
import '../models/intubation.dart';
import 'intubation_form/step1_antecedents.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({Key? key}) : super(key: key);

  void _generateAndShowPdf(BuildContext context, patient) async {
    // Basic implementation: take the first intubation of this patient
    final provider = Provider.of<IntubationProvider>(context, listen: false);
    final intubations = provider.intubations.where((i) => i.patientId == patient.id).toList();
    if (intubations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Aucune intubation pour ce patient.')));
      return;
    }
    
    final pdfService = PdfService();
    final pdfBytes = await pdfService.generatePdf(patient, intubations.first);
    
    await Printing.layoutPdf(onLayout: (format) async => pdfBytes);
  }

  void _showPatientActions(BuildContext context, patient) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Nouvelle Intubation'),
              onTap: () {
                Navigator.pop(ctx);
                Provider.of<IntubationProvider>(context, listen: false).startIntubation(patient.id!);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const Step1Antecedents()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Voir le dossier (PDF)'),
              onTap: () {
                Navigator.pop(ctx);
                _generateAndShowPdf(context, patient);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Supprimer le patient', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(ctx);
                showDialog(
                  context: context,
                  builder: (dialogCtx) => AlertDialog(
                    title: const Text('Confirmer la suppression'),
                    content: const Text('Êtes-vous sûr de vouloir supprimer ce patient et toutes ses intubations associées ? Cette action est irréversible.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text('Annuler')),
                      TextButton(
                        onPressed: () {
                          Provider.of<PatientProvider>(context, listen: false).deletePatient(patient.id!);
                          Navigator.pop(dialogCtx);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Patient supprimé avec succès')));
                        },
                        child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  )
                );
              },
            ),
          ],
        );
      },
    );
  }

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
              onChanged: (value) => patientProvider.setSearchQuery(value),
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
            onTap: () => _showPatientActions(context, patient),
          );
        },
      ),
    );
  }
}
