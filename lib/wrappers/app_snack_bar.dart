import 'package:crafty_bay/themes/app_color.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/cupertino.dart';

class AppSnackBar {
  static show({required String message, required BuildContext context}) {
    floatingSnackBar(
      message: message,
      context: context,
      backgroundColor: AppColor.appPrimaryColor,
    );
  }
}
