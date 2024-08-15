import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppbarStyle {
  static AppBarTheme getLightAppBarTheme() => AppBarTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: 70,
        shadowColor: Colors.black.withOpacity(0.1),
        titleTextStyle: const TextStyle(
            fontSize: 16, color: Colors.black, fontFamily: "Poppins"),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColor.appPrimaryColor,
        ),
      );
}
