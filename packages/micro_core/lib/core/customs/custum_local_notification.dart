import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustumLocalNotification {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

  CustumLocalNotification._run();

  static final CustumLocalNotification _singleton =
      CustumLocalNotification._run();
  static CustumLocalNotification get instance => _singleton;
  factory CustumLocalNotification() => _singleton;

  Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    flutterLocalNotificationsPlugin
        .initialize(const InitializationSettings(android: android, iOS: iOS));
  }

  Future<FlutterLocalNotificationsPlugin> androidConfiguration() async {
    final localNotification = FlutterLocalNotificationsPlugin();
    await localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    return localNotification;
  }

  Future<void> sendNotification(RemoteNotification notification,
      AndroidNotification androidNotification) async {
    final androidNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channel.description,
      icon: androidNotification.smallIcon,
      importance: Importance.max,
    );
    final notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(notification.hashCode,
        notification.title, notification.body, notificationDetails);
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String description,
    String? payload,
    bool withCustumSound = false,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      description,
      NotificationDetails(
        android: AndroidNotificationDetails(
            channel.id, channel.name, channel.description,
            importance: Importance.max,
            icon: '@mipmap/launcher_icon',
            sound: withCustumSound
                ? const RawResourceAndroidNotificationSound('som_de_apito.mp3')
                : null),
        iOS: IOSNotificationDetails(
            sound: withCustumSound ? 'som_de_apito.aiff' : null),
      ),
    );
  }
}
