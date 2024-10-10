import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/themes/app_elevated_button_style.dart';
import 'package:crafty_bay/themes/app_text_theme.dart';
import 'package:crafty_bay/themes/app_textfield_style.dart';
import 'package:crafty_bay/themes/appbar_style.dart';
import 'package:crafty_bay/themes/bottom_navigation_theme.dart';
import 'package:flutter/material.dart';

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
    bottomNavigationBarTheme: BottomNavigationTheme.getBottomNavigationBarDarkTheme(),
  );
}
