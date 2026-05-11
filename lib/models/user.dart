class User {
  final int? id;
  final String email;
  final String hashedPassword;

  User({this.id, required this.email, required this.hashedPassword});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'hashedPassword': hashedPassword,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      hashedPassword: map['hashedPassword'],
    );
  }
}
