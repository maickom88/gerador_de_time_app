import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_commons/app/domain/entities/goal_entity.dart';
import 'package:micro_commons/app/domain/entities/match_entity.dart';
import 'package:micro_commons/app/domain/entities/team_entity.dart';
import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/api_datasource.dart';
import '../../data/errors/server_error.dart';

import '../../domain/usecases/initialize_cup.dart';
import '../../domain/usecases/initialize_match.dart';
import '../../domain/usecases/register_goal.dart';
import '../../domain/usecases/update_match.dart';
import '../../domain/usecases/update_team.dart';

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

  @override
  Future<MatchEntity> initializeMatch(MatchParams params) async {
    try {
      final result = await _dio.http
          .post<Map<String, dynamic>>('/match', data: params.toMap());
      return MatchEntity.fromMap(result.data!);
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<GoalEntity> registerGoal(GoalParams params) async {
    try {
      final result = await _dio.http
          .post<Map<String, dynamic>>('/goal', data: params.toMap());
      return GoalEntity.fromMap(result.data!);
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<CupEntity> getCup(String params) async {
    try {
      final result = await _dio.http.get<Map<String, dynamic>>('/cup/$params');
      return CupEntity.fromMap(result.data!);
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<MatchEntity> updateMatch(UpdateMatchParams params) async {
    try {
      final result = await _dio.http
          .put<Map<String, dynamic>>('/match', data: params.toMap());
      return MatchEntity.fromMap(result.data!);
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<TeamEntity> updateTeam(UpdateTeamParams params) async {
    try {
      final result = await _dio.http
          .put<Map<String, dynamic>>('/team', data: params.toMap());
      return TeamEntity.fromMap(result.data!);
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<void> removeGoal(String params) async {
    try {
      await _dio.http.delete<void>('/goal/$params');
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<CupEntity> finishCup(String params) async {
    try {
      final result =
          await _dio.http.post<Map<String, dynamic>>('/cup/$params/finishing');
      return CupEntity.fromMap(result.data!);
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }
}
