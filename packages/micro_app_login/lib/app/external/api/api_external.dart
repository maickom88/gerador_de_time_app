import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:micro_core/core/customs/custum_firebase_auth.dart';

import '../../data/datasources/api_datasource.dart';
import '../../data/errors/server_error.dart';
import '../../domain/entities/user_entity.dart';

class ApiExternal implements ApiDatasource {
  final CustumDio _dio;
  final SharedPreferences _sharedPreferences;
  ApiExternal(this._dio, this._sharedPreferences);

  @override
  Future<UserEntity> notifyApi(String? params) async {
    try {
      final token = await CustumFirebaseAuth.getToken();
      CustumDio.instance.setToken(token);
      final result =
          await _dio.http.put<Map<String, dynamic>>('/user/notifier');
      final user = UserEntity.fromMap(result.data!);
      await _sharedPreferences.setString('user', user.toJson());
      return user;
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }
}
