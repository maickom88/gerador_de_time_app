import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../customs/custum_dio.dart';
import '../customs/custum_firebase_auth.dart';
import '../customs/custum_firebase_message.dart';
import '../customs/custum_in_app_purchase.dart';
import '../customs/custum_local_storage.dart';
import '../customs/custum_remote_config.dart';

class ZoneGuard {
  static Future<void> withObservableError(Function() body) async {
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        await Firebase.initializeApp();
        await CustumRemoteConfig.instance.initialize();
        await CustumLocalStorage.instance.initialize();
        final token = await CustumFirebaseAuth.getToken();
        await CustumFirebaseMessage.instance.initialize();
        await CustumDio.instance
            .initialize(CustumRemoteConfig.instance.apiBase, token: token);

        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
        await CustumInAppPurchese.instance.initialize();
        body.call();
      },
      ((error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack)),
    );
  }
}
