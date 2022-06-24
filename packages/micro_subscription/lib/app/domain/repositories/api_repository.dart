import 'package:micro_commons/app/domain/entities/purchase_entity.dart';
import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';

import '../usecases/register_purchase.dart';

abstract class ApiRepository {
  Future<Either<Failure, PurchaseEntity>> registerPurchase(
      PurchaseParams params);
}
