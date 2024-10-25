import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../core/services/network_service/internet_service_error.dart';
import '../../../core/services/response/failure.dart';
import '../../profile/shared/state_holders/profile_state.dart';

class CompleteProfileViewHelper {
  static Future<void> createProfile({
    required ProfileState profileState,
    required String name,
    required String mobile,
    required String city,
    required String shippingAddress,
    required String postCode,
    required String customerAddress,
    required String state,
    required String country,
    required BuildContext context,
  }) async {
    bool status = await profileState.createProfile(
      name: name,
      mobile: mobile,
      city: city,
      shippingAddress: shippingAddress,
      postCode: postCode,
      customerAddress: customerAddress,
      state: state,
      country: country,
    );
    if (!status && context.mounted) {
      Failure failure = profileState.response as Failure;
      if (context.mounted) {
        InternetServiceError.showErrorSnackBar(
          failure: failure,
          context: context,
        );
      }
      return;
    }
    if (context.mounted) {
      navigator!.pop();
    }
  }
}
