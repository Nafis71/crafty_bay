import 'package:crafty_bay/features/profile/shared/state_holders/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../core/services/network_service/internet_service_error.dart';
import '../../../../core/services/response/failure.dart';
import '../../../../core/wrappers/app_snack_bar.dart';
import '../../profile_view/utils/profile_view_strings.dart';

class ProfileUpdateHelper {
  static ProfileUpdateHelper? _instance;

  ProfileUpdateHelper._();

  factory ProfileUpdateHelper() => _instance ??= ProfileUpdateHelper._();

  Future<void> initiateProfileUpdate({
    required String profileUpdationType,
    required String changedValue,
    required BuildContext context,
    required ProfileState profileState,
  }) async {
    bool status = await profileState.updateProfile(
      profileUpdationType,
      changedValue,
    );
    if (status && context.mounted) {
      AppSnackBar.show(
        message: ProfileViewStrings.profileUpdationSuccessText,
        context: context,
        isError: false,
      );
      navigator!.pop();
      return;
    }
    if (context.mounted) {
      Failure failure = profileState.response as Failure;
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
    }
  }
}
