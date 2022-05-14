import '../../domain/entities/sport_entity.dart';

abstract class ApiDatasource {
  Future<List<SportEntity>> getSports();
}
