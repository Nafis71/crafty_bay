import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme getTextThemeLight() => TextTheme(
        bodyMedium: getDefaultStyle().copyWith(
          color: Colors.grey.shade600,
        ),
        titleLarge: getDefaultStyle().copyWith(
          fontSize: 30,
          fontFamily: "Poppins Medium",
          fontWeight: FontWeight.bold,
          color: Colors.black.withOpacity(0.7),
        ),
        titleMedium: getDefaultStyle().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins Medium",
          color: Color(0xFF505050),
        ),
        titleSmall: getDefaultStyle().copyWith(
          color: Colors.black.withOpacity(0.7),
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: getDefaultStyle()
            .copyWith(fontSize: 15, color: Colors.black.withOpacity(0.6)),
        labelMedium: getDefaultStyle()
            .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
        bodySmall: getDefaultStyle().copyWith(
          fontSize: 12,
          color: Colors.grey,
        ),
      );

  static TextTheme getTextThemeDark() => getTextThemeLight().copyWith(
        titleMedium: getDefaultStyle().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins Medium",
          color: Color(0xFFF3F3F3),
        ),
        bodyMedium: getDefaultStyle().copyWith(
          color: Colors.white,
        ),
        labelSmall: getDefaultStyle().copyWith(
          fontSize: 15,
          color: Colors.white,
        ),
        titleSmall: getDefaultStyle().copyWith(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: getDefaultStyle().copyWith(
          fontSize: 30,
          fontFamily: "Poppins Medium",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

  static TextStyle getDefaultStyle() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins",
        color: Colors.white,
      );
}
