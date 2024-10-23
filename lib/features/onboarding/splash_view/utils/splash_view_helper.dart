import 'package:crafty_bay/features/onboarding/splash_view/state_holders/splash_view_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/prefetch_service/prefetch_service.dart';
import '../../../profile/shared/state_holders/profile_state.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../cart/state_holders/cart_view_state.dart';

class SplashViewHelper {
  static Future<void> prefetchData({
    required SplashViewState splashViewState,
    required BuildContext context,
  }) async {
    if (splashViewState.isBusy) {
      return;
    }
    splashViewState.setIsBusy = true;
    if (!await Get.find<ProfileState>().isTokenExpired()) {
      await PrefetchService.prefetchProductWishList(
        Get.find<ProfileState>().token,
      );
      await Get.find<CartViewState>().getCartList(
        Get.find<ProfileState>().token,
      );
    } else {
      await Future.delayed(Duration(seconds: 3));
    }
    await Get.find<ProfileState>().loadUserDataFromStorage();
    Navigator.pushNamed(context, AppRoutes.baseNavigationView);
  }
}
