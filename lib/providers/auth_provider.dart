import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/database_service.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  final AuthService _authService = AuthService();
  
  User? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    final userData = await DatabaseService.instance.getUserByEmail(email);
    if (userData != null) {
      final user = User.fromMap(userData);
      final hashedInput = _authService.hashPassword(password);
      if (user.hashedPassword == hashedInput) {
        _currentUser = user;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<bool> register(String email, String password) async {
    final existingUser = await DatabaseService.instance.getUserByEmail(email);
    if (existingUser != null) {
      return false; // User already exists
    }
    final hashedPassword = _authService.hashPassword(password);
    final user = User(email: email, hashedPassword: hashedPassword);
    int id = await DatabaseService.instance.insertUser(user.toMap());
    _currentUser = User(id: id, email: email, hashedPassword: hashedPassword);
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
