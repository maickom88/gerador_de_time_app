import 'package:micro_commons/app/domain/entities/purchase_entity.dart';

import '../../domain/usecases/register_purchase.dart';

abstract class ApiDatasource {
  Future<PurchaseEntity> registerPurchase(PurchaseParams params);
}
