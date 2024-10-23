import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../core/services/network_service/internet_service_error.dart';
import '../../../../core/services/response/failure.dart';
import '../../../../core/services/response/success.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/wrappers/app_snack_bar.dart';
import 'package:flutter/material.dart';

import '../../shared/state_holders/auth_state.dart';
import 'login_view_strings.dart';

class LoginViewHelper {
  static Future<void> sendOTP(
      {required AuthState authState,
      required String email,
      required BuildContext context,
      required Function(dynamic) futureExecution}) async {
    bool status = await authState.sendOTP(email.trim());
    if (status && context.mounted) {
      Map<String, dynamic> viewData = {
        "email": email.trim(),
        "futureExecution": futureExecution
      };
      navigator!.pushReplacementNamed(
        AppRoutes.otpVerificationView,
        arguments: viewData,
      );
      return;
    }
    if (!status && context.mounted && authState.response is Success) {
      AppSnackBar.show(
        message: LoginViewStrings.otpSendError,
        context: context,
        isError: true,
      );
    }
    Failure failure = authState.response as Failure;
    if (context.mounted) {
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
    }
  }
}
