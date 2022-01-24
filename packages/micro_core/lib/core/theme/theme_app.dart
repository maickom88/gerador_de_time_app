import 'package:flutter/material.dart';

import 'app_typography.dart';
import 'theme.dart';

class ThemeApp {
  static TextTheme textTheme() => const TextTheme();

  static ThemeData theme() {
    return ThemeData(
      fontFamily: AppTypography.fontFamily,
      primarySwatch: Colors.yellow,
      primaryColor: AppColor.primaryColor,
      secondaryHeaderColor: AppColor.secondaryColor,
      appBarTheme: buildAppBarTheme(),
      inputDecorationTheme: buildInputDecorationTheme(),
      elevatedButtonTheme: buildElevatedButtonThemeData(),
    );
  }

  static AppBarTheme buildAppBarTheme() {
    return const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColor.primaryColor,
      ),
    );
  }

  static InputDecorationTheme buildInputDecorationTheme() {
    return InputDecorationTheme(
      fillColor: Colors.white,
      errorMaxLines: 3,
      errorStyle: AppTypography.t14().copyWith(color: AppColor.primaryColor),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: AppColor.primaryColor),
        borderRadius: BorderRadius.circular(5),
      ),
      filled: true,
      labelStyle: AppTypography.t16(fontName: 'Inter')
          .copyWith(color: AppColor.textLight),
      hintStyle: AppTypography.t16(fontName: 'Inter')
          .copyWith(color: AppColor.textLight),
      prefixStyle: AppTypography.t16(fontName: 'Inter')
          .copyWith(color: AppColor.textLight),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  static ElevatedButtonThemeData buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          AppTypography.t18(fontName: 'Inter'),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: AppDefault.defaultBorderRadius(radius: 10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          const Color(0xFFF3C955),
        ),
      ),
    );
  }
}
