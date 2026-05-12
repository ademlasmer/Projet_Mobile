import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../services/database_service.dart';

class PatientProvider with ChangeNotifier {
  List<Patient> _patients = [];
  String _searchQuery = '';
  
  List<Patient> get patients {
    if (_searchQuery.isEmpty) return _patients;
    return _patients.where((p) => p.nom.toLowerCase().contains(_searchQuery.toLowerCase()) || p.prenom.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  PatientProvider() {
    loadPatients();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
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

  Future<void> deletePatient(int id) async {
    await DatabaseService.instance.deletePatient(id);
    _patients.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
