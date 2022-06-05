import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/team_entity.dart';
import 'package:micro_core/core/errors/errors.dart';

import '../../domain/repositories/api_repository.dart';
import '../../domain/usecases/register_team.dart';
import '../datasources/api_datasource.dart';

class Api implements ApiRepository {
  final ApiDatasource apiDatasource;
  Api({
    required this.apiDatasource,
  });

  @override
  Future<Either<Failure, TeamEntity>> registerTeam(
      RegisterTeamParams params) async {
    try {
      return Right(await apiDatasource.registerTeam(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
