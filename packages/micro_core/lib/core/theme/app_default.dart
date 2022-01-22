import 'package:flutter/material.dart';

class AppDefault {
  static const double hPadding = 10;
  static const double vPadding = 12;

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
      Navigator.pop(context, result);

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static Future<T?> navigateTo<T extends Object?>(
    BuildContext context, {
    required String routeName,
    Object? arguments,
  }) =>
      Navigator.of(context).pushNamed<T>(routeName);
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