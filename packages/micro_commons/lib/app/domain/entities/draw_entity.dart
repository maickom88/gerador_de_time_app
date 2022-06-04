import 'package:flutter/material.dart';

import 'player_entity.dart';

class DrawEntity {
  final List<TeamEntity> teams;
  DrawEntity({
    required this.teams,
  });

  factory DrawEntity.fromMap(Map<String, dynamic> map) {
    return DrawEntity(
      teams: List<TeamEntity>.from(
          map['teams']?.map((x) => TeamEntity.fromMap(x))),
    );
  }
}

class TeamEntity {
  String? title;
  Color? color;
  final List<PlayerEntity> team;
  TeamEntity({
    this.title,
    this.color,
    required this.team,
  });

  factory TeamEntity.fromMap(Map<String, dynamic> map) {
    return TeamEntity(
      team: List<PlayerEntity>.from(
          map['team']?.map((x) => PlayerEntity.fromMap(x))),
    );
  }
}
