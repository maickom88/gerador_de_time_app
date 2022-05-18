import 'dart:convert';

class PositionEntity {
  final String? guid;
  final String name;
  final String? description;
  PositionEntity({
    this.guid,
    required this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'name': name,
      'description': description,
    };
  }

  factory PositionEntity.fromMap(Map<String, dynamic> map) {
    return PositionEntity(
      guid: map['guid'],
      name: map['name'] ?? '',
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PositionEntity.fromJson(String source) =>
      PositionEntity.fromMap(json.decode(source));
}
