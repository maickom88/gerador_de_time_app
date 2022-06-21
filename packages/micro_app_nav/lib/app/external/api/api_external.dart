import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_commons/app/domain/entities/notification_entity.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/api_datasource.dart';
import '../../data/errors/server_error.dart';
import '../../domain/entities/cup_information_entity.dart';
import '../../domain/entities/position_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/sport_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/save_player_usecase.dart';

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

  @override
  Future<List<PositionEntity>> getPositions() async {
    try {
      final result = await _dio.http.get<List>('/position');
      final positions = result.data!
          .map((position) => PositionEntity.fromMap(position))
          .toList();
      return positions;
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<PlayerEntity> savePLayer(SavePlayerParams params) async {
    try {
      final result = await _dio.http
          .post<Map<String, dynamic>>('/player', data: params.toMap());
      final player = PlayerEntity.fromMap(result.data!);
      return player;
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
  Future<List<CupEntity>> getCups(String params) async {
    try {
      final result = await _dio.http
          .get<List>('/cup', queryParameters: {"email_user": params});
      final cups = result.data!.map((cup) => CupEntity.fromMap(cup)).toList();
      return cups;
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<CupInformationEntity> getCupInformation(String params) async {
    try {
      final result = await _dio.http
          .get<Map<String, dynamic>>('/cup/$params/informations');
      return CupInformationEntity.fromMap(result.data!);
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<List<NotificationEntity>> getNotifications(String params) async {
    try {
      final result = await _dio.http.get<List>('/notification/user/$params');
      final notifications =
          result.data!.map((cup) => NotificationEntity.fromMap(cup)).toList();
      return notifications;
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<UserEntity> updateUser(UserEntity params) async {
    try {
      final result = await _dio.http
          .put<Map<String, dynamic>>('/user', data: params.toMap());
      final skill = UserEntity.fromMap(result.data!);
      return skill;
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<void> clearNotification(String params) async {
    try {
      await _dio.http.put<void>('/notification/clear/user/$params');
      return;
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }
}
