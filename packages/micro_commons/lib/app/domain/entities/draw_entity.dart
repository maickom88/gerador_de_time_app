import 'package:flutter/material.dart';

import 'player_entity.dart';

class DrawEntity {
  String? guidSport;
  String? email;
  final List<TeamDrawEntity> teams;
  DrawEntity({
    required this.teams,
    this.email,
    this.guidSport,
  });

  factory DrawEntity.fromMap(Map<String, dynamic> map) {
    return DrawEntity(
      teams: List<TeamDrawEntity>.from(
          map['teams']?.map((x) => TeamDrawEntity.fromMap(x))),
    );
  }
}

class TeamDrawEntity {
  String? title;
  Color? color;
  final List<PlayerEntity> team;
  TeamDrawEntity({
    this.title,
    this.color,
    required this.team,
  });

  factory TeamDrawEntity.fromMap(Map<String, dynamic> map) {
    return TeamDrawEntity(
      team: List<PlayerEntity>.from(
          map['team']?.map((x) => PlayerEntity.fromMap(x))),
    );
  }
}
