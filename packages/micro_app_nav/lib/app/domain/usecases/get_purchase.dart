import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/purchase_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class GetPurchase implements Usecase<String, PurchaseEntity> {
  final ApiRepository apiRepository;
  GetPurchase({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, PurchaseEntity>> call(String params) async {
    return await apiRepository.getPurchase(params);
  }
}
