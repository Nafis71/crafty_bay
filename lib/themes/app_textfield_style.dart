import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';

class AppTextFieldStyle{
  static InputDecorationTheme getTextFieldTheme() => InputDecorationTheme(
    isDense: true,
    hintStyle:  TextStyle(
      color: Colors.grey.shade400,
      fontFamily: "Poppins",
      fontWeight: FontWeight.normal
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.appPrimaryColor, width: 1)
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.appPrimaryColor,width: 2)
    )
  );
}