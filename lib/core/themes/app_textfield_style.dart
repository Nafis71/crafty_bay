import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTextFieldStyle {
  static InputDecorationTheme getTextFieldTheme() => InputDecorationTheme(
        isDense: true,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontFamily: "Poppins",
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        floatingLabelStyle: TextStyle(
          color: AppColor.appPrimaryColor,
          fontFamily: "Poppins",
        ),
        labelStyle:
            TextStyle(fontFamily: "Poppins", color: Colors.grey, fontSize: 13),
        enabledBorder:
            getOutlineInputBorder(width: 1, color: AppColor.appPrimaryColor),
        focusedBorder:
            getOutlineInputBorder(width: 2, color: AppColor.appPrimaryColor),
        errorBorder: getOutlineInputBorder(width: 2, color: Colors.red),
        focusedErrorBorder: getOutlineInputBorder(width: 2, color: Colors.red),
      );

  static OutlineInputBorder getOutlineInputBorder(
      {required double width, required Color color}) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: width));
  }
}
