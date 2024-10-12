import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';

import '../themes/app_color.dart';

class AppSnackBar {
  static show({
    required String message,
    required BuildContext context,
    required bool isError,
    Color? color,
  }) {
    floatingSnackBar(
      message: message,
      context: context,
      backgroundColor: (!isError)
          ? AppColor.appPrimaryColor
          : (color == null)
              ? Colors.red.shade400
              : color,
    );
  }
}
