import 'package:micro_commons/app/domain/entities/team_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';

import '../usecases/register_team.dart';

abstract class ApiRepository {
  Future<Either<Failure, TeamEntity>> registerTeam(RegisterTeamParams params);
}
