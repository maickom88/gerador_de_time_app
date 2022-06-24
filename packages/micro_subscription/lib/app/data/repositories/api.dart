import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/purchase_entity.dart';

import '../../domain/repositories/api_repository.dart';
import '../../domain/usecases/register_purchase.dart';
import '../datasources/api_datasource.dart';

class Api implements ApiRepository {
  final ApiDatasource apiDatasource;
  Api({
    required this.apiDatasource,
  });

  @override
  Future<Either<Failure, PurchaseEntity>> registerPurchase(
      PurchaseParams params) async {
    try {
      return Right(await apiDatasource.registerPurchase(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
