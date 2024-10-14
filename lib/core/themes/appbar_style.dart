import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

class AppbarStyle {
  static AppBarTheme getLightAppBarTheme() => AppBarTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: 70,
        shadowColor: Colors.black.withOpacity(0.1),
        titleTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.black.withOpacity(0.6),
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColor.appPrimaryColor,
        ),
      );

  static AppBarTheme getDarkAppBarTheme() => getLightAppBarTheme().copyWith(
        backgroundColor: AppColor.darkComponentsColor,
        surfaceTintColor: AppColor.darkComponentsColor,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: AppColor.darkComponentsColor),
        titleTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
        ),
      );
}
