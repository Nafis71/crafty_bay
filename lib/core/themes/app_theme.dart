import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_elevated_button_style.dart';
import 'app_text_theme.dart';
import 'app_textfield_style.dart';
import 'appbar_style.dart';
import 'bottom_navigation_theme.dart';

class AppTheme {
  static ThemeData getLightTheme() => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColor.scaffoldBackGroundColorLight,
        primaryColor: AppColor.appPrimaryColor,
        primarySwatch: Colors.cyan,
        textTheme: AppTextTheme.getTextThemeLight(),
        inputDecorationTheme: AppTextFieldStyle.getTextFieldTheme(),
        elevatedButtonTheme: AppElevatedButtonStyle.getElevatedButton(),
        appBarTheme: AppbarStyle.getLightAppBarTheme(),
        bottomNavigationBarTheme:
            BottomNavigationTheme.getBottomNavigationBarLightTheme(),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        fontFamily: "Poppins",
      );

  static ThemeData getDarkTheme() => getLightTheme().copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColor.scaffoldBackgroundColorDark,
        appBarTheme: AppbarStyle.getDarkAppBarTheme(),
        textTheme: AppTextTheme.getTextThemeDark(),
        bottomNavigationBarTheme:
            BottomNavigationTheme.getBottomNavigationBarDarkTheme(),
      );
}
