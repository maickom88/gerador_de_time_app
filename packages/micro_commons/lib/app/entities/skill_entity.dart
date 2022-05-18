import 'dart:convert';

class SkillEntity {
  final String? guid;
  final int strength;
  final int velocity;
  final int completion;
  final int dribble;
  SkillEntity({
    this.guid,
    required this.strength,
    required this.velocity,
    required this.completion,
    required this.dribble,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'strength': strength,
      'velocity': velocity,
      'completion': completion,
      'dribble': dribble,
    };
  }

  factory SkillEntity.fromMap(Map<String, dynamic> map) {
    return SkillEntity(
      guid: map['guid'],
      strength: map['strength']?.toInt() ?? 0,
      velocity: map['velocity']?.toInt() ?? 0,
      completion: map['completion']?.toInt() ?? 0,
      dribble: map['dribble']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SkillEntity.fromJson(String source) =>
      SkillEntity.fromMap(json.decode(source));
}
