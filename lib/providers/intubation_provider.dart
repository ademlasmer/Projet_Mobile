import 'package:flutter/material.dart';
import '../models/intubation.dart';
import '../services/database_service.dart';

class IntubationProvider with ChangeNotifier {
  Intubation? _currentIntubation;
  int _currentStep = 1;
  List<Intubation> _intubations = [];

  Intubation? get currentIntubation => _currentIntubation;
  int get currentStep => _currentStep;
  List<Intubation> get intubations => _intubations;

  IntubationProvider() {
    loadIntubations();
  }

  Future<void> loadIntubations() async {
    final data = await DatabaseService.instance.getIntubations();
    _intubations = data.map((item) => Intubation.fromMap(item)).toList();
    notifyListeners();
  }

  void setStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void startIntubation(int patientId) {
    _currentIntubation = Intubation(patientId: patientId);
    _currentStep = 1;
    notifyListeners();
  }

  void updateIntubation(Intubation intubation) {
    _currentIntubation = intubation;
    notifyListeners();
  }

  Future<void> saveIntubation(Intubation intubation) async {
    int id;
    if (intubation.id == null) {
      id = await DatabaseService.instance.insertIntubation(intubation.toMap());
    } else {
      id = intubation.id!;
      await DatabaseService.instance.updateIntubation(intubation.toMap());
    }
    await loadIntubations(); // reload
  }
}
