import 'package:micro_app_login/app/micro_app_login_resolver.dart';
import 'package:micro_core/micro_core.dart';

class Resolvers {
  static List<MicroApp> apps = [
    MicroAppLoginResolver(),
  ];
}
