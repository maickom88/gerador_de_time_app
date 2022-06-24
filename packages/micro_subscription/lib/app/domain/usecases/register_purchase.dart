import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/purchase_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class RegisterPurchase implements Usecase<PurchaseParams, PurchaseEntity> {
  final ApiRepository apiRepository;
  RegisterPurchase({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, PurchaseEntity>> call(PurchaseParams params) async {
    return await apiRepository.registerPurchase(params);
  }
}

class PurchaseParams {
  final String guidUser;
  final double? priceBr;
  final double? priceUsd;
  final String? platform;
  PurchaseParams({
    required this.guidUser,
    this.priceBr,
    this.priceUsd,
    this.platform,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid_user': guidUser,
      'price_br': priceBr,
      'price_usd': priceUsd,
      'platform': platform,
    };
  }
}
