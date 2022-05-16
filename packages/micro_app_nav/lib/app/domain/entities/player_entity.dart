import 'dart:convert';

import 'position_entity.dart';
import 'skill_entity.dart';

class PlayerEntity {
  final String? guid;
  final String name;
  final String? photo;
  final PositionEntity position;
  final SkillEntity skills;
  PlayerEntity({
    this.guid,
    required this.name,
    this.photo,
    required this.position,
    required this.skills,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'name': name,
      'photo': photo,
      'position': position.toMap(),
      'skills': skills.toMap(),
    };
  }

  factory PlayerEntity.fromMap(Map<String, dynamic> map) {
    return PlayerEntity(
      guid: map['guid'],
      name: map['name'] ?? '',
      photo: map['photo'],
      position: PositionEntity.fromMap(map['position']),
      skills: SkillEntity.fromMap(map['skills']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayerEntity.fromJson(String source) =>
      PlayerEntity.fromMap(json.decode(source));
}
