import 'package:micro_core/core/customs/custum_firebase_auth.dart';

class BaseRoutes {
  static late String initialRoute;

  static Future<void> initialize() async {
    if (CustumFirebaseAuth.userISLogged()) {
      initialRoute = home;
    } else {
      initialRoute = login;
    }
  }

  static const String login = '/welcome';
  static const String home = '/nav';
}
