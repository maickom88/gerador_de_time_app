import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/theme.dart';

extension ThemeDataDefault on Widget {
  Widget themeTwo() {
    return Theme(
      data: ThemeData(
        primaryColor: AppColor.secondaryColor,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          errorMaxLines: 3,
          errorStyle:
              AppTypography.t14().copyWith(color: AppColor.primaryColor),
          errorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 1, color: AppColor.primaryColor),
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
        ),
      ),
      child: this,
    );
  }
}
