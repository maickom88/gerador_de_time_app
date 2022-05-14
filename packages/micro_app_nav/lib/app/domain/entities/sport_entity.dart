import 'dart:convert';

class SportEntity {
  final String guid;
  final String name;
  final String description;
  final String photoUrL;
  final String tutorial;
  final String icon;
  final bool isAvailable;

  SportEntity({
    required this.guid,
    required this.name,
    required this.description,
    required this.photoUrL,
    required this.tutorial,
    required this.icon,
    required this.isAvailable,
  });

  factory SportEntity.fromMap(Map<String, dynamic> map) {
    return SportEntity(
      guid: map['guid'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      photoUrL: map['photo'] ?? '',
      tutorial: map['tutorial'] ?? '',
      icon: map['icon'] ?? '',
      isAvailable: map['is_available'] ?? false,
    );
  }

  factory SportEntity.fromJson(String source) =>
      SportEntity.fromMap(json.decode(source));
}
