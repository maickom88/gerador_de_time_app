import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

class CustumBackgroundService {
  late FlutterBackgroundService _backgroundService;
  FlutterBackgroundService get service => _backgroundService;

  CustumBackgroundService._run();
  static final CustumBackgroundService _singleton =
      CustumBackgroundService._run();
  static CustumBackgroundService get instance => _singleton;

  factory CustumBackgroundService() => _singleton;

  Future<void> initialize() async {
    _backgroundService = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
    service.startService();
  }

  bool onIosBackground(ServiceInstance service) {
    WidgetsFlutterBinding.ensureInitialized();

    return true;
  }

  void onStart(ServiceInstance service) async {
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: "My App Service",
          content: "Updated at ${DateTime.now()}",
        );
      }

      String? device;
      if (Platform.isAndroid) {
        device = 'Android';
      }

      if (Platform.isIOS) {
        device = 'iOS';
      }

      service.invoke(
        'update',
        {
          "current_date": DateTime.now().toIso8601String(),
          "device": device,
        },
      );
    });
  }
}
