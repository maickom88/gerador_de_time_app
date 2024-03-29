import 'package:flutter/material.dart';

class AppTypography {
  static const fontFamily = 'Poppins';

  static TextStyle t16({String? fontName = fontFamily}) =>
      TextStyle(fontFamily: fontName, fontSize: 16);

  static TextStyle t16WithW300({String? fontName = fontFamily}) => TextStyle(
      fontFamily: fontName, fontSize: 16, fontWeight: FontWeight.w300);

  static TextStyle t16WithW800({String? fontName = fontFamily}) => TextStyle(
      fontFamily: fontName, fontSize: 16, fontWeight: FontWeight.w800);

  static TextStyle t18WithW800({String? fontName = fontFamily}) => TextStyle(
      fontFamily: fontName, fontSize: 18, fontWeight: FontWeight.w800);

  static TextStyle t18({String? fontName = fontFamily}) =>
      TextStyle(fontFamily: fontName, fontSize: 18);

  static TextStyle t14({String? fontName = fontFamily}) =>
      TextStyle(fontFamily: fontName, fontSize: 14);

  static TextStyle t12({String? fontName = fontFamily}) =>
      TextStyle(fontFamily: fontName, fontSize: 12);

  static TextStyle t12WithW800({String? fontName = fontFamily}) => TextStyle(
      fontFamily: fontName, fontSize: 12, fontWeight: FontWeight.w800);

  static TextStyle t13WithW800({String? fontName = fontFamily}) => TextStyle(
      fontFamily: fontName, fontSize: 13, fontWeight: FontWeight.w800);

  static TextStyle t22WithW800({String? fontName = fontFamily}) => TextStyle(
      fontFamily: fontName, fontSize: 22, fontWeight: FontWeight.w800);

  static TextStyle t22WithW300({String? fontName = fontFamily}) => TextStyle(
      fontFamily: fontName, fontSize: 22, fontWeight: FontWeight.w300);

  static TextStyle t28WithW800({String? fontName = fontFamily}) => TextStyle(
      fontFamily: fontName, fontSize: 28, fontWeight: FontWeight.w800);

  static TextStyle t28({String? fontName = fontFamily}) =>
      TextStyle(fontFamily: fontName, fontSize: 28);
}
