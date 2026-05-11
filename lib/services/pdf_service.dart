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
              pw.Text('Rapport d\'Intubation', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Text('Patient: ${patient.nom} ${patient.prenom}'),
              pw.Text('Date de Naissance: ${patient.dateNaissance.toLocal().toString().split(' ')[0]}'),
              pw.Text('BMI: ${patient.bmi.toStringAsFixed(1)}'),
              pw.SizedBox(height: 20),
              pw.Text('Antécédents: ${intubation.antecedents ?? 'Aucun'}'),
            ],
          );
        },
      ),
    );

    return await pdf.save();
  }
}
