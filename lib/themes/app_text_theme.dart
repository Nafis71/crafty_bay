import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme getTextThemeLight() => TextTheme(
        bodyMedium: getDefaultStyle().copyWith(color:Colors.grey.shade600,),
        titleLarge: getDefaultStyle().copyWith(
          fontSize: 30,
          fontFamily: "Poppins Medium",
          fontWeight: FontWeight.bold,
          color: AppColor.titleLargeTextColorLight,
        ),
        titleMedium: getDefaultStyle().copyWith(
          fontSize: 18,
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
        labelMedium: getDefaultStyle()
            .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
        bodySmall: getDefaultStyle().copyWith(
          fontSize: 12,
          color: Colors.grey,
        ),
      );

  static TextTheme getTextThemeDark()=> getTextThemeLight().copyWith(
    titleMedium: getDefaultStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: "Poppins Medium",
      color: AppColor.titleMediumTextColorDark,
    ),
    bodyMedium: getDefaultStyle().copyWith(color:Colors.white,),
  );

  static TextStyle getDefaultStyle() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins",
        color: Colors.white,
      );
}
