import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/api_datasource.dart';
import '../../data/errors/server_error.dart';

import '../../domain/usecases/initialize_cup.dart';

class ApiExternal implements ApiDatasource {
  final CustumDio _dio;
  ApiExternal(this._dio);

  @override
  Future<CupEntity> initializeCup(CupParams params) async {
    try {
      final result = await _dio.http
          .post<Map<String, dynamic>>('/cup', data: params.toMap());
      return CupEntity.fromMap(result.data!);
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }
}
