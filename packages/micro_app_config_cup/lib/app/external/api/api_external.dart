import 'package:micro_commons/app/domain/entities/team_entity.dart';
import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/api_datasource.dart';
import '../../data/errors/server_error.dart';
import '../../domain/usecases/register_team.dart';

class ApiExternal implements ApiDatasource {
  final CustumDio _dio;
  ApiExternal(this._dio);

  @override
  Future<TeamEntity> registerTeam(RegisterTeamParams params) async {
    try {
      final result = await _dio.http
          .post<Map<String, dynamic>>('/team', data: params.toMap());
      return TeamEntity.fromMap(result.data!);
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }
}
