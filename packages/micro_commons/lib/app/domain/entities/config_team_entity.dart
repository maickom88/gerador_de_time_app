import 'team_entity.dart';

class ConfigTeamEntity {
  final List<TeamEntity?> teams;
  final int time;
  final int? timeAdditions;
  final String? guidSport;
  final String email;
  ConfigTeamEntity({
    required this.teams,
    required this.time,
    this.timeAdditions,
    this.guidSport,
    required this.email,
  });
}
