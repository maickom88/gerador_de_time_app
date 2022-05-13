import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class AppLog {
  static Future<void> writeLog(String message) async {
    await FirebaseCrashlytics.instance.log(message);
  }
}
