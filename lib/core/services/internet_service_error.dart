import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:flutter/cupertino.dart';

import '../utils/app_strings.dart';
import '../wrappers/app_snack_bar.dart';

class InternetServiceError {
  static void showErrorSnackBar(
      {required Failure failure, required BuildContext context}) {
    if (failure.statusCode == 600 ||
        failure.statusCode == 601 ||
        failure.statusCode == 500) {
      AppSnackBar.show(
        message: failure.errorMessage.toString(),
        context: context,
        isError: true,
      );
    } else {
      AppSnackBar.show(
        message: AppStrings.unknownError,
        context: context,
        isError: true,
      );
    }
  }
}
