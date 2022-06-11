import 'dart:convert';

import 'cup_entity.dart';
import 'team_entity.dart';

class MatchEntity {
  final String guid;
  final TeamEntity homeTeam;
  final TeamEntity opposingTeam;
  final CupEntity cup;
  final int time;
  final int? timeAdditions;
  final int? totalTimePause;
  final int? finalTime;
  final int? totalGoals;

  MatchEntity({
    required this.guid,
    required this.homeTeam,
    required this.opposingTeam,
    required this.cup,
    required this.time,
    this.timeAdditions,
    this.totalTimePause,
    this.finalTime,
    this.totalGoals,
  });

  factory MatchEntity.fromMap(Map<String, dynamic> map) {
    return MatchEntity(
      guid: map['guid'] ?? '',
      homeTeam: TeamEntity.fromMap(map['home_team']),
      opposingTeam: TeamEntity.fromMap(map['opposing_team']),
      cup: CupEntity.fromMap(map['cup']),
      time: map['time']?.toInt() ?? 0,
      timeAdditions: map['time_additions']?.toInt(),
      totalTimePause: map['total_time_pause']?.toInt(),
      finalTime: map['final_time']?.toInt(),
      totalGoals: map['total_goals']?.toInt(),
    );
  }

  factory MatchEntity.fromJson(String source) =>
      MatchEntity.fromMap(json.decode(source));
}
