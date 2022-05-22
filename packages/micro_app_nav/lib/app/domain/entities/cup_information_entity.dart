import 'dart:convert';

import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_commons/app/domain/entities/team_entity.dart';

class CupInformationEntity {
  final TeamEntity? winner;
  final TeamEntity? worstTeam;
  final PlayerEntity? bestPlayer;
  final PlayerEntity? goalkeeper;
  final DateTime date;
  CupInformationEntity({
    required this.date,
    this.winner,
    this.worstTeam,
    this.bestPlayer,
    this.goalkeeper,
  });

  factory CupInformationEntity.fromMap(Map<String, dynamic> map) {
    return CupInformationEntity(
        winner:
            map['winner'] != null ? TeamEntity.fromMap(map['winner']) : null,
        worstTeam: map['worst_team'] != null
            ? TeamEntity.fromMap(map['worst_team'])
            : null,
        bestPlayer: map['best_player']['player'] != null
            ? PlayerEntity.fromMap(map['best_player']['player'])
            : null,
        goalkeeper: map['goalkeeper'] != null
            ? PlayerEntity.fromMap(map['goalkeeper'])
            : null,
        date: DateTime.parse(map['created_at']));
  }

  factory CupInformationEntity.fromJson(String source) =>
      CupInformationEntity.fromMap(json.decode(source));
}
