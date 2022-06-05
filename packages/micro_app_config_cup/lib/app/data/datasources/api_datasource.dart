import 'package:micro_commons/app/domain/entities/team_entity.dart';

import '../../domain/usecases/register_team.dart';

abstract class ApiDatasource {
  Future<TeamEntity> registerTeam(RegisterTeamParams params);
}
