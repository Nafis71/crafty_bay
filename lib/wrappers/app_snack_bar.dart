import 'package:crafty_bay/themes/app_color.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static show(
      {required String message,
      required BuildContext context,
      required bool isError}) {
    floatingSnackBar(
      message: message,
      context: context,
      backgroundColor:
          (!isError) ? AppColor.appPrimaryColor : Colors.red.shade400,
    );
  }
}
