import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('intubation_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        hashedPassword TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE patients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        prenom TEXT NOT NULL,
        sexe TEXT NOT NULL,
        dateNaissance TEXT NOT NULL,
        telephone TEXT,
        bmi REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE intubations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patientId INTEGER NOT NULL,
        antecedents TEXT,
        saos INTEGER NOT NULL DEFAULT 0,
        diabete INTEGER NOT NULL DEFAULT 0,
        goitre INTEGER NOT NULL DEFAULT 0,
        scoreAsa INTEGER,
        mallampati TEXT,
        dtm TEXT,
        ouvertureBuccale TEXT,
        difficultePrevue TEXT,
        typeIntubation TEXT,
        tentatives INTEGER,
        utiliseVideoLaryngoscope INTEGER NOT NULL DEFAULT 0,
        scoreCormack INTEGER,
        intubationDifficile INTEGER NOT NULL DEFAULT 0,
        complicationsLibres TEXT,
        photosPath TEXT,
        audioPath TEXT,
        FOREIGN KEY (patientId) REFERENCES patients (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<int> insertPatient(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('patients', row);
  }

  Future<List<Map<String, dynamic>>> getPatients() async {
    final db = await instance.database;
    return await db.query('patients');
  }

  Future<int> updatePatient(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update('patients', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertIntubation(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('intubations', row);
  }

  Future<List<Map<String, dynamic>>> getIntubations() async {
    final db = await instance.database;
    return await db.query('intubations');
  }

  Future<int> updateIntubation(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update('intubations', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('users', row);
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await instance.database;
    final results = await db.query('users', where: 'email = ?', whereArgs: [email]);
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }
}
