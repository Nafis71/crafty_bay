import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppTextTheme{
  static TextTheme getTextThemeLight() => TextTheme(
    bodyMedium: getDefaultStyle().copyWith(
      color: Colors.grey
    ),
    titleLarge: getDefaultStyle().copyWith(
      fontSize: 30,
      fontFamily: "Poppins Medium",
      fontWeight: FontWeight.bold,
      color: AppColor.titleTextColorLight,
    ),
    titleMedium:  getDefaultStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    )
  );

  static TextStyle getDefaultStyle() => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: "Poppins",
    color: Colors.white,
  );
}