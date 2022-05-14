import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';

import '../../domain/entities/sport_entity.dart';
import '../../domain/repositories/api_repository.dart';
import '../datasources/api_datasource.dart';

class Api implements ApiRepository {
  final ApiDatasource apiDatasource;
  Api({
    required this.apiDatasource,
  });
  @override
  Future<Either<Failure, List<SportEntity>>> getSports() async {
    try {
      return Right(await apiDatasource.getSports());
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
