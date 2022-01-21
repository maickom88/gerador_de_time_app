import 'package:flutter/material.dart';

typedef WidgetBuildArgs = Widget Function(BuildContext context, Object? args);
late GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
