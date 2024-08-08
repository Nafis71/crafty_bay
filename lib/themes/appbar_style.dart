import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppbarStyle{
  static AppBarTheme getLightAppBarTheme() =>   AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColor.appPrimaryColor,
    )
  );
}