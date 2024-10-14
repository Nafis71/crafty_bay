import 'package:flutter/material.dart';

import 'app_color.dart';

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

  static BottomNavigationBarThemeData getBottomNavigationBarDarkTheme() =>
      getBottomNavigationBarLightTheme()
          .copyWith(backgroundColor: AppColor.darkComponentsColor);
}
