class Patient {
  final int? id;
  final String nom;
  final String prenom;
  final String sexe;
  final DateTime dateNaissance;
  final String? telephone;
  final double bmi;

  Patient({
    this.id,
    required this.nom,
    required this.prenom,
    required this.sexe,
    required this.dateNaissance,
    this.telephone,
    required this.bmi,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'sexe': sexe,
      'dateNaissance': dateNaissance.toIso8601String(),
      'telephone': telephone,
      'bmi': bmi,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      sexe: map['sexe'],
      dateNaissance: DateTime.parse(map['dateNaissance']),
      telephone: map['telephone'],
      bmi: map['bmi'],
    );
  }
}
