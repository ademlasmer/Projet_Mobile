class Intubation {
  final int? id;
  final int patientId;
  
  // Step 1: Antécédents
  final String? antecedents;
  final bool saos;
  final bool diabete;
  final bool goitre;

  // Step 2: Evaluation
  final int? scoreAsa;
  final String? mallampati;
  final String? dtm;
  final String? ouvertureBuccale;

  // Step 3: Risque
  final String? difficultePrevue;

  // Step 4: Per-intubation
  final String? typeIntubation;
  final int? tentatives;
  final bool utiliseVideoLaryngoscope;
  final int? scoreCormack;

  // Step 5: Complications
  final bool intubationDifficile;
  final String? complicationsLibres;

  // Step 6: Données complémentaires
  final String? photosPath;
  final String? audioPath;

  Intubation({
    this.id,
    required this.patientId,
    this.antecedents,
    this.saos = false,
    this.diabete = false,
    this.goitre = false,
    this.scoreAsa,
    this.mallampati,
    this.dtm,
    this.ouvertureBuccale,
    this.difficultePrevue,
    this.typeIntubation,
    this.tentatives,
    this.utiliseVideoLaryngoscope = false,
    this.scoreCormack,
    this.intubationDifficile = false,
    this.complicationsLibres,
    this.photosPath,
    this.audioPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'antecedents': antecedents,
      'saos': saos ? 1 : 0,
      'diabete': diabete ? 1 : 0,
      'goitre': goitre ? 1 : 0,
      'scoreAsa': scoreAsa,
      'mallampati': mallampati,
      'dtm': dtm,
      'ouvertureBuccale': ouvertureBuccale,
      'difficultePrevue': difficultePrevue,
      'typeIntubation': typeIntubation,
      'tentatives': tentatives,
      'utiliseVideoLaryngoscope': utiliseVideoLaryngoscope ? 1 : 0,
      'scoreCormack': scoreCormack,
      'intubationDifficile': intubationDifficile ? 1 : 0,
      'complicationsLibres': complicationsLibres,
      'photosPath': photosPath,
      'audioPath': audioPath,
    };
  }

  factory Intubation.fromMap(Map<String, dynamic> map) {
    return Intubation(
      id: map['id'],
      patientId: map['patientId'],
      antecedents: map['antecedents'],
      saos: map['saos'] == 1,
      diabete: map['diabete'] == 1,
      goitre: map['goitre'] == 1,
      scoreAsa: map['scoreAsa'],
      mallampati: map['mallampati'],
      dtm: map['dtm'],
      ouvertureBuccale: map['ouvertureBuccale'],
      difficultePrevue: map['difficultePrevue'],
      typeIntubation: map['typeIntubation'],
      tentatives: map['tentatives'],
      utiliseVideoLaryngoscope: map['utiliseVideoLaryngoscope'] == 1,
      scoreCormack: map['scoreCormack'],
      intubationDifficile: map['intubationDifficile'] == 1,
      complicationsLibres: map['complicationsLibres'],
      photosPath: map['photosPath'],
      audioPath: map['audioPath'],
    );
  }
}
