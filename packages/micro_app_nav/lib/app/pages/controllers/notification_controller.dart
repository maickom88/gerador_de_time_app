import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/clear_notification.dart';
import '../../domain/usecases/get_notifications.dart';
import '../states/notification_state.dart';

class NotificationController extends ValueNotifier<NotificationState> {
  final GetNotifications _getNotifications;
  final ClearNotification _clearNotification;

  final SharedPreferences _sharedPreferences;

  late final ValueNotifier<UserEntity?> _userEntity =
      ValueNotifier<UserEntity?>(null);

  UserEntity? get userEntity => _userEntity.value;
  NotificationController(
    this._getNotifications,
    this._clearNotification,
    this._sharedPreferences,
  ) : super(InitialNotificationState());

  Future<void> getNotifications() async {
    if (_sharedPreferences.containsKey('user')) {
      userEntity = UserEntity.fromJson(_sharedPreferences.getString('user')!);
    }
    value = NotificationLoandingState();
    final result = await _getNotifications.call(userEntity!.guid);
    result.fold((resultError) {
      value = NotificationErrorState(error: resultError);
    }, (resultSuccess) async {
      await Future.delayed(const Duration(seconds: 2));
      resultSuccess.sort((b, a) {
        return a.createdAt.compareTo(b.createdAt);
      });

      value = NotificationSuccessState(notifications: resultSuccess);
    });
  }

  Future<void> clearNotification() async {
    value = NotificationLoandingState();
    final result = await _clearNotification.call(userEntity!.guid);
    result.fold((resultError) {
      value = NotificationErrorState(error: resultError);
    }, (resultSuccess) async {
      value = NotificationSuccessState(notifications: []);
    });
  }

  set userEntity(UserEntity? user) {
    _userEntity.value = user;
    notifyListeners();
  }
}
