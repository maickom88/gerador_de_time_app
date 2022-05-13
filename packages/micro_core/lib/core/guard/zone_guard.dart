import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../customs/custum_dio.dart';
import '../customs/custum_remote_config.dart';

class ZoneGuard {
  static Future<void> withObservableError(Function() body) async {
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();
        await CustumRemoteConfig.instance.initialize();
        CustumDio.instance.initialize(CustumRemoteConfig.instance.apiBase);
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
        body.call();
      },
      ((error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack)),
    );
  }
}