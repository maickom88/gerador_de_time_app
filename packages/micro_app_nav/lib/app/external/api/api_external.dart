import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/api_datasource.dart';
import '../../data/errors/server_error.dart';
import '../../domain/entities/sport_entity.dart';

class ApiExternal implements ApiDatasource {
  final CustumDio _dio;
  ApiExternal(this._dio);

  @override
  Future<List<SportEntity>> getSports() async {
    try {
      final result = await _dio.http.get<List>('/sport');
      final sports =
          result.data!.map((sport) => SportEntity.fromMap(sport)).toList();
      return sports;
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }
}
