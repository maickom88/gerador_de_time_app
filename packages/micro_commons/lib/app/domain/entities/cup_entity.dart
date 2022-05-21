import 'dart:convert';

import 'sport_entity.dart';
import 'team_entity.dart';

class CupEntity {
  final String? guid;
  final String responsibleEmail;
  final int time;
  final SportEntity sport;
  final int timeAdditions;
  final TeamEntity? winner;
  final bool isDraft;
  final DateTime date;
  final List<TeamEntity> teams;
  CupEntity({
    this.guid,
    required this.responsibleEmail,
    required this.time,
    required this.sport,
    required this.timeAdditions,
    required this.winner,
    required this.isDraft,
    required this.date,
    required this.teams,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'responsible_email': responsibleEmail,
      'time': time,
      'time_additions': timeAdditions,
      'winner': winner?.toMap(),
      'is_draft': isDraft,
      'date': date.millisecondsSinceEpoch,
      'teams': teams.map((x) => x.toMap()).toList(),
    };
  }

  factory CupEntity.fromMap(Map<String, dynamic> map) {
    return CupEntity(
      guid: map['guid'],
      responsibleEmail: map['responsible_email'] ?? '',
      time: map['time']?.toInt() ?? 0,
      sport: SportEntity.fromMap(map['sport']),
      timeAdditions: map['time_additions']?.toInt() ?? 0,
      winner: TeamEntity.fromMap(map['winner']),
      isDraft: map['is_draft'] ?? false,
      date: DateTime.parse(map['created_at']),
      teams: List<TeamEntity>.from(
          map['teams']?.map((x) => TeamEntity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CupEntity.fromJson(String source) =>
      CupEntity.fromMap(json.decode(source));
}
