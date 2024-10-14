import 'package:flutter/material.dart';

import 'app_color.dart';

class AppSearchBarTheme {
  static ThemeData getSearchBarThemeLight(BuildContext context) => ThemeData(
        primaryColor: AppColor.appPrimaryColor,
        textTheme: TextTheme(
          bodyMedium: Theme.of(context).textTheme.bodyMedium,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.appPrimaryColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
          contentPadding: const EdgeInsets.all(10),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.appPrimaryColor,
            ),
          ),
        ),
      );

  static ThemeData getSearchBarThemeDark(BuildContext context) =>
      getSearchBarThemeLight(context).copyWith(
        appBarTheme: const AppBarTheme(
          color: AppColor.darkComponentsColor,
          surfaceTintColor: AppColor.darkComponentsColor,
        ),
        scaffoldBackgroundColor: AppColor.scaffoldBackgroundColorDark,
        textTheme: TextTheme(
          bodyMedium: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
      );
}
