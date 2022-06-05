import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_core/core/errors/errors.dart';

import '../../domain/repositories/api_repository.dart';

import '../../domain/usecases/initialize_cup.dart';
import '../datasources/api_datasource.dart';

class Api implements ApiRepository {
  final ApiDatasource apiDatasource;
  Api({
    required this.apiDatasource,
  });

  @override
  Future<Either<Failure, CupEntity>> initializeCup(CupParams params) async {
    try {
      return Right(await apiDatasource.initializeCup(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
