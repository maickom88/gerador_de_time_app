import 'dart:convert';

import 'game_entity.dart';
import 'player_entity.dart';

class GoalEntity {
  final String? guid;
  final GameEntity game;
  final PlayerEntity player;
  final String timeGoals;

  GoalEntity({
    this.guid,
    required this.game,
    required this.player,
    required this.timeGoals,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'game': game.toMap(),
      'player': player.toMap(),
      'time_goals': timeGoals,
    };
  }

  factory GoalEntity.fromMap(Map<String, dynamic> map) {
    return GoalEntity(
      guid: map['guid'],
      game: GameEntity.fromMap(map['game']),
      player: PlayerEntity.fromMap(map['player']),
      timeGoals: map['time_goals'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GoalEntity.fromJson(String source) =>
      GoalEntity.fromMap(json.decode(source));
}
