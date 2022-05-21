import 'dart:convert';

import 'cup_entity.dart';
import 'team_entity.dart';

class GameEntity {
  final String? guid;
  final TeamEntity homeTeam;
  final TeamEntity opposingTeam;
  final CupEntity cup;
  final int time;
  final int timeAdditions;
  final int totalTimePause;
  final int finalTime;
  final int totalGoals;
  GameEntity({
    this.guid,
    required this.homeTeam,
    required this.opposingTeam,
    required this.cup,
    required this.time,
    required this.timeAdditions,
    required this.totalTimePause,
    required this.finalTime,
    required this.totalGoals,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'home_team': homeTeam.toMap(),
      'opposing_team': opposingTeam.toMap(),
      'cup': cup.toMap(),
      'time': time,
      'time_additions': timeAdditions,
      'total_time_pause': totalTimePause,
      'final_time': finalTime,
      'total_goals': totalGoals,
    };
  }

  factory GameEntity.fromMap(Map<String, dynamic> map) {
    return GameEntity(
      guid: map['guid'],
      homeTeam: TeamEntity.fromMap(map['home_team']),
      opposingTeam: TeamEntity.fromMap(map['opposing_team']),
      cup: CupEntity.fromMap(map['cup']),
      time: map['time']?.toInt() ?? 0,
      timeAdditions: map['time_additions']?.toInt() ?? 0,
      totalTimePause: map['total_time_pause']?.toInt() ?? 0,
      finalTime: map['final_time']?.toInt() ?? 0,
      totalGoals: map['total_goals']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameEntity.fromJson(String source) =>
      GameEntity.fromMap(json.decode(source));
}
