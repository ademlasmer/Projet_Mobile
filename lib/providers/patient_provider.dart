import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../services/database_service.dart';

class PatientProvider with ChangeNotifier {
  List<Patient> _patients = [];
  
  List<Patient> get patients => _patients;

  PatientProvider() {
    loadPatients();
  }

  Future<void> loadPatients() async {
    final data = await DatabaseService.instance.getPatients();
    _patients = data.map((item) => Patient.fromMap(item)).toList();
    notifyListeners();
  }

  Future<void> addPatient(Patient patient) async {
    int id = await DatabaseService.instance.insertPatient(patient.toMap());
    final newPatient = Patient(
      id: id,
      nom: patient.nom,
      prenom: patient.prenom,
      sexe: patient.sexe,
      dateNaissance: patient.dateNaissance,
      telephone: patient.telephone,
      bmi: patient.bmi,
    );
    _patients.add(newPatient);
    notifyListeners();
  }
  
  void setPatients(List<Patient> patients) {
    _patients = patients;
    notifyListeners();
  }
}
