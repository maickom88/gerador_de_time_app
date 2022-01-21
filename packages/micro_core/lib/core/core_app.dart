import 'package:micro_core/utils/core_utils.dart';

abstract class MicroApp {
  String get appName;

  Map<String, WidgetBuildArgs> get routes;
}
