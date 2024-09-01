import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';

class BottomNavigationTheme {
  static BottomNavigationBarThemeData getBottomNavigationBarLightTheme() =>
      BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 40,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColor.appPrimaryColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontFamily: "Poppins",
        ),
      );
}
