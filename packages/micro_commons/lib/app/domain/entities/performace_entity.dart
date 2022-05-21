import 'dart:convert';

import 'goal_entity.dart';

class PerfomaceEntity {
  final int totalNumberOfCupParticipations;
  final int totalWinnerCups;
  final List<GoalEntity> goals;
  PerfomaceEntity({
    required this.totalNumberOfCupParticipations,
    required this.totalWinnerCups,
    required this.goals,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalNumberOfCupParticipations': totalNumberOfCupParticipations,
      'totalWinnerCups': totalWinnerCups,
      'goals': goals.map((x) => x.toMap()).toList(),
    };
  }

  factory PerfomaceEntity.fromMap(Map<String, dynamic> map) {
    return PerfomaceEntity(
      totalNumberOfCupParticipations:
          map['total_number_of_cup_participations']?.toInt() ?? 0,
      totalWinnerCups: map['total_winner_cups']?.toInt() ?? 0,
      goals: List<GoalEntity>.from(
          map['goals']?.map((x) => GoalEntity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PerfomaceEntity.fromJson(String source) =>
      PerfomaceEntity.fromMap(json.decode(source));
}
