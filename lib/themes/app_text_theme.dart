import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme getTextThemeLight() => TextTheme(
      bodyMedium: getDefaultStyle().copyWith(color: Colors.grey),
      titleLarge: getDefaultStyle().copyWith(
        fontSize: 30,
        fontFamily: "Poppins Medium",
        fontWeight: FontWeight.bold,
        color: AppColor.titleLargeTextColorLight,
      ),
      titleMedium: getDefaultStyle().copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins Medium",
        color: AppColor.titleMediumTextColorLight,
      ),
      titleSmall: getDefaultStyle().copyWith(
          color: Colors.black.withOpacity(0.7),
          fontSize: 15,
          fontWeight: FontWeight.bold),
      labelSmall: getDefaultStyle()
          .copyWith(fontSize: 16, color: Colors.black.withOpacity(0.6)),
      labelMedium: getDefaultStyle().copyWith(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.black
      ));

  static TextStyle getDefaultStyle() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins",
        color: Colors.white,
      );
}
