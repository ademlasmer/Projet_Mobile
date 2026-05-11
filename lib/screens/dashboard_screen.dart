import 'package:flutter/material.dart';
import 'patient_list_screen.dart';
import 'patient_form_screen.dart';
import 'intubation_form/step1_antecedents.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tableau de Bord'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(context, 'Nouveau Patient', Icons.person_add, () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PatientFormScreen()));
                  }),
                  _buildDashboardCard(context, 'Liste des Patients', Icons.people, () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PatientListScreen()));
                  }),
                  _buildDashboardCard(context, 'Nouvelle Intubation', Icons.medical_services, () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const Step1Antecedents()));
                  }),
                  _buildDashboardCard(context, 'Rapports PDF', Icons.picture_as_pdf, () {
                    // Show reports
                  }),
                ],
              ),
            ),
            const Divider(),
            const Text('Derniers dossiers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Expanded(
              child: Center(child: Text('Aucun dossier récent')),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.teal),
            const SizedBox(height: 16),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
