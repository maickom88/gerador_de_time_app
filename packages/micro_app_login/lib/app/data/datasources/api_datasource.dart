import '../../domain/entities/user_entity.dart';

abstract class ApiDatasource {
  Future<UserEntity> notifyApi(String? params);
}
