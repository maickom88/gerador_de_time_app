import 'package:micro_commons/app/domain/entities/notification_entity.dart';
import 'package:micro_core/core/errors/errors.dart';

abstract class NotificationState {}

class NotificationLoandingState extends NotificationState {}

class InitialNotificationState extends NotificationState {}

class NotificationSuccessState extends NotificationState {
  final List<NotificationEntity> notifications;
  NotificationSuccessState({
    required this.notifications,
  });
}

class NotificationErrorState extends NotificationState {
  final Failure error;
  NotificationErrorState({
    required this.error,
  });
}
