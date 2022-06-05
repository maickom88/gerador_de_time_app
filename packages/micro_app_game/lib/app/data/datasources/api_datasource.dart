import 'package:micro_commons/app/domain/entities/cup_entity.dart';

import '../../domain/usecases/initialize_cup.dart';

abstract class ApiDatasource {
  Future<CupEntity> initializeCup(CupParams params);
}
