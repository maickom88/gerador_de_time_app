import 'dart:convert';

import 'player_entity.dart';

class TeamEntity {
  final String? guid;
  final String name;
  final String color;
  final int vitories;
  final int goals;
  final int goalsNegative;
  final List<PlayerEntity> players;
  TeamEntity({
    this.guid,
    required this.name,
    required this.color,
    required this.vitories,
    required this.goals,
    required this.goalsNegative,
    required this.players,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'name': name,
      'color': color,
      'vitories': vitories,
      'goals': goals,
      'goals_negative': goalsNegative,
      'players': players.map((x) => x.toMap()).toList(),
    };
  }

  factory TeamEntity.fromMap(Map<String, dynamic> map) {
    return TeamEntity(
      guid: map['guid'],
      name: map['name'] ?? '',
      color: map['color'] ?? '',
      vitories: map['vitories']?.toInt() ?? 0,
      goals: map['goals']?.toInt() ?? 0,
      goalsNegative: map['goals_negative']?.toInt() ?? 0,
      players: List<PlayerEntity>.from(
          map['players']?.map((x) => PlayerEntity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamEntity.fromJson(String source) =>
      TeamEntity.fromMap(json.decode(source));
}
