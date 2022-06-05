import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'custum_local_notification.dart';

class CustumFirebaseMessage {
  CustumFirebaseMessage._run();
  static final CustumFirebaseMessage _singleton = CustumFirebaseMessage._run();
  static CustumFirebaseMessage get instance => _singleton;
  factory CustumFirebaseMessage() => _singleton;

  Future<void> initialize() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            sound: true, badge: true, alert: true);
    await sendRequestPermission();
    await CustumLocalNotification.instance.initialize();

    FirebaseMessaging.onMessage.listen((event) {
      RemoteNotification? notification = event.notification;
      AndroidNotification? android = event.notification?.android;

      if (notification != null && android != null) {
        CustumLocalNotification.instance
            .sendNotification(notification, android);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final data = event.data;
      debugPrint(data.toString());
    });
  }

  Future<void> sendRequestPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  Future<String?> getTokenMessage() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('========================================');
    debugPrint('TOKEN ON FIREBASE: $token');
    debugPrint('========================================');
    return token;
  }
}
