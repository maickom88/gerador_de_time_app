import 'package:flutter/material.dart';
import 'core_app.dart';
import '../utils/core_utils.dart';

abstract class BaseApp {
  List<MicroApp> get microApps;

  Map<String, WidgetBuildArgs> get baseRoutes;

  final Map<String, WidgetBuildArgs> routes = {};

  void registerRoutes();

  Route? generateRoute(RouteSettings settings);
}
