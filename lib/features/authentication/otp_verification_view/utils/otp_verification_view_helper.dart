import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/network_service/internet_service_error.dart';
import '../../../../core/services/response/failure.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/wrappers/app_snack_bar.dart';
import '../../shared/state_holders/auth_state.dart';
import '../state_holders/countdown_timer.dart';
import 'otp_verification_strings.dart';

class OtpVerificationViewHelper {
  static Future<void> verifyOTP({
    required AuthState authState,
    required BuildContext context,
    required String email,
    required String otp,
    required Function(dynamic) futureExecution,
  }) async {
    if (Get.find<CountdownTimerState>().timeLeft == 0) {
      AppSnackBar.show(
          message: OtpVerificationStrings.invalidOTP,
          context: context,
          isError: true);
      return;
    }
    bool status = await authState.verifyOTP(
      email,
      otp,
      futureExecution,
    );
    if (status && context.mounted && !authState.hasUserData) {
      navigator!.pushReplacementNamed(AppRoutes.profileDetailView);
      return;
    }
    if (status && context.mounted && authState.hasUserData) {
      navigator!.pop();
      return;
    }
    Failure failure = authState.response as Failure;
    if (!status &&
        context.mounted &&
        (failure.statusCode != 600 ||
            failure.statusCode != 601 ||
            failure.statusCode != 500)) {
      AppSnackBar.show(
          message: OtpVerificationStrings.invalidOTP,
          context: context,
          isError: true);
      return;
    }
    if (context.mounted) {
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
    }
  }
}
