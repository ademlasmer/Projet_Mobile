import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import '../models/intubation.dart';
import '../models/patient.dart';

class PdfService {
  Future<Uint8List> generatePdf(Patient patient, Intubation intubation) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Rapport d\'Intubation', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Informations Patient', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text('Patient: ${patient.nom} ${patient.prenom}'),
              pw.Text('Sexe: ${patient.sexe}'),
              pw.Text('Date de Naissance: ${patient.dateNaissance.toLocal().toString().split(' ')[0]}'),
              pw.Text('BMI: ${patient.bmi.toStringAsFixed(1)}'),
              pw.SizedBox(height: 20),
              pw.Text('Étape 1: Antécédents', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text('SAOS: ${intubation.saos ? 'Oui' : 'Non'}'),
              pw.Text('Diabète: ${intubation.diabete ? 'Oui' : 'Non'}'),
              pw.Text('Goitre: ${intubation.goitre ? 'Oui' : 'Non'}'),
              pw.Text('Autres antécédents: ${intubation.antecedents ?? 'Aucun'}'),
              pw.SizedBox(height: 10),
              pw.Text('Étape 2: Évaluation', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text('Score ASA: ${intubation.scoreAsa ?? 'Non défini'}'),
              pw.Text('Mallampati: ${intubation.mallampati ?? 'Non défini'}'),
              pw.Text('Distance thyro-mentonnière: ${intubation.dtm ?? 'Non définie'}'),
              pw.Text('Ouverture buccale: ${intubation.ouvertureBuccale ?? 'Non définie'}'),
              pw.SizedBox(height: 10),
              pw.Text('Étape 3: Risque', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text('Intubation prévue: ${intubation.difficultePrevue ?? 'Non défini'}'),
              pw.SizedBox(height: 10),
              pw.Text('Étape 4: Per-intubation', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text('Type d\'intubation: ${intubation.typeIntubation ?? 'Non défini'}'),
              pw.Text('Tentatives: ${intubation.tentatives ?? 0}'),
              pw.Text('Vidéo-laryngoscope: ${intubation.utiliseVideoLaryngoscope ? 'Oui' : 'Non'}'),
              pw.Text('Score Cormack: ${intubation.scoreCormack ?? 'Non défini'}'),
              pw.SizedBox(height: 10),
              pw.Text('Étape 5: Complications', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text('Intubation difficile avérée: ${intubation.intubationDifficile ? 'Oui' : 'Non'}'),
              pw.Text('Complications libres: ${intubation.complicationsLibres ?? 'Aucune'}'),
            ],
          );
        },
      ),
    );

    return await pdf.save();
  }
}
