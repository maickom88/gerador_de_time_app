import 'package:flutter/material.dart';

import '../../utils/core_utils.dart';

class AppDefault {
  static const double hPadding = 12;
  static const double vPadding = 16;

  static BorderRadius defaultBorderRadiusOnly(
          {double topLeft = 17, double topRight = 17}) =>
      BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
      );
  static BorderRadius defaultBorderRadius({double radius = 17}) =>
      BorderRadius.circular(radius);

  static SizedBox defaultSpaceHeight({double height = 20}) =>
      SizedBox(height: height);
  static SizedBox defaultSpaceWidth({double width = 12}) =>
      SizedBox(width: width);

  static List<BoxShadow> defaultBoxShadow({
    double y = 4,
    double x = 0,
    Color color = Colors.black12,
    double blur = 6,
  }) =>
      [
        BoxShadow(
          offset: Offset(y, x),
          color: color,
          blurRadius: blur,
        ),
      ];

  static void close<T extends Object?>(BuildContext context, [T? result]) =>
      navigatorKey.currentState?.pop(result);

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static Future<T?> navigateTo<T extends Object?>(BuildContext context,
      {required String routeName, Object? arguments, bool withReturn = true}) {
    if (withReturn) {
      return Navigator.of(context)
          .pushNamed<T>(routeName, arguments: arguments);
    }
    return Navigator.of(context)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<T?>? navigateToRemoveAll<T extends Object?>(
      BuildContext context,
      {required String routeName}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
        routeName, (Route<dynamic> route) => false);
  }

  static Future<T?> showDefaultLoad<T>(BuildContext context, Widget widget) {
    return showDialog<T>(
      context: context,
      builder: (context) => widget,
      barrierColor: Colors.white.withOpacity(0.6),
      useSafeArea: false,
      barrierDismissible: false,
    );
  }

  static Future<T?> navigateToWidget<T extends Object?>(BuildContext context,
      {required Widget widget, Object? arguments, bool withReturn = true}) {
    final settings = RouteSettings(arguments: arguments);
    if (withReturn) {
      return Navigator.push<T>(
        context,
        MaterialPageRoute(builder: (context) => widget, settings: settings),
      );
    }
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => widget, settings: settings),
    );
  }
}

extension AppDefaultPadding on Widget {
  Padding withAllPadding({double padding = AppDefault.vPadding}) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Padding withSymPadding({
    double hPadding = AppDefault.hPadding,
    double vPadding = AppDefault.vPadding,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
        child: this,
      );
  Padding withLeftPadding({double leftPadding = AppDefault.hPadding}) =>
      Padding(padding: EdgeInsets.only(left: leftPadding), child: this);

  Padding withRightPadding({double rightPadding = AppDefault.hPadding}) =>
      Padding(padding: EdgeInsets.only(right: rightPadding), child: this);

  Padding withTopPadding({double topPadding = AppDefault.vPadding}) =>
      Padding(padding: EdgeInsets.only(top: topPadding), child: this);

  Padding withBottomPadding({double bottomPadding = AppDefault.vPadding}) =>
      Padding(padding: EdgeInsets.only(bottom: bottomPadding), child: this);
}
