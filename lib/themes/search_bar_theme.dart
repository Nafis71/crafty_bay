import 'package:flutter/material.dart';

import 'app_color.dart';

class AppSearchBarTheme {
  static ThemeData getSearchBarTheme(BuildContext context) => ThemeData(
        primaryColor: AppColor.appPrimaryColor,
        textTheme: TextTheme(
          bodyMedium: Theme.of(context).textTheme.bodyMedium,
        ),
        appBarTheme: const AppBarTheme(
            color: Colors.white, surfaceTintColor: Colors.white),
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
}
