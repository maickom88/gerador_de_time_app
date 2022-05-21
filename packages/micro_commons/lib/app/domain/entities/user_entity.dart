import 'dart:convert';

class UserEntity {
  final String guid;
  final String email;
  final String name;
  final bool firstAccess;
  final String photo;
  final String role;
  UserEntity({
    required this.guid,
    required this.email,
    required this.name,
    required this.firstAccess,
    required this.photo,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'email': email,
      'name': name,
      'first_access': firstAccess,
      'photo': photo,
      'role': role,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      guid: map['guid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      firstAccess: map['first_access'] ?? false,
      photo: map['photo'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));
}
