import 'package:micro_commons/app/factories/build_resources.dart';

import '../pages/controllers/notification_controller.dart';
import 'build_resources.dart';

NotificationController buildNotificationController() => NotificationController(
    getNotificationsUsecase, clearNotificationsUsecase, storage);
