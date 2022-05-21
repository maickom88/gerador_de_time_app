import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:dio/dio.dart';

import '../data/datasources/api_datasource.dart';
import '../data/errors/server_error.dart';
import '../domain/entities/performace_entity.dart';
import '../domain/entities/player_entity.dart';
import '../domain/entities/skill_entity.dart';

class ApiExternal implements ApiDatasource {
  final CustumDio _dio;
  ApiExternal(this._dio);

  @override
  Future<List<PlayerEntity>> getPlayers(String params) async {
    try {
      final result = await _dio.http.get<List>('/player/user/$params');
      final players =
          result.data!.map((player) => PlayerEntity.fromMap(player)).toList();
      return players;
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<SkillEntity> saveSkill(SkillEntity params) async {
    try {
      final result = await _dio.http
          .post<Map<String, dynamic>>('/skill', data: params.toMap());
      final skill = SkillEntity.fromMap(result.data!);
      return skill;
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<void> removePlayers(List<String> params) async {
    try {
      for (var element in params) {
        await _dio.http.delete('/player/$element');
      }
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<PerfomaceEntity> getPerformacePlayer(String params) async {
    try {
      final result = await _dio.http
          .get<Map<String, dynamic>>('/player/$params/performace');
      final performace = PerfomaceEntity.fromMap(result.data!);
      return performace;
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }
}
