import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/api_repository.dart';
import '../datasources/api_datasource.dart';

class Api implements ApiRepository {
  final ApiDatasource apiDatasource;
  Api({
    required this.apiDatasource,
  });

  @override
  Future<Either<Failure, UserEntity>> notifyApi(String? params) async {
    try {
      return Right(await apiDatasource.notifyApi(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
