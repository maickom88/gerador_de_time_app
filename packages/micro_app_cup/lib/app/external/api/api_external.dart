import 'package:micro_commons/app/domain/entities/draw_entity.dart';
import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/api_datasource.dart';
import '../../data/errors/server_error.dart';
import '../../domain/usecases/draw_players_usecase.dart';

class ApiExternal implements ApiDatasource {
  final CustumDio _dio;
  ApiExternal(this._dio);

  @override
  Future<DrawEntity> drawPlayers(DrawParams params) async {
    try {
      final result = await _dio.http
          .post<Map<String, dynamic>>('/draw', data: params.toMap());
      return DrawEntity.fromMap(result.data!);
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }
}
