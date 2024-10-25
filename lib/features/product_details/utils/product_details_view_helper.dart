import 'dart:async';

import 'package:crafty_bay/features/cart/state_holders/cart_view_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/network_service/internet_service_error.dart';
import '../../../core/services/response/failure.dart';
import '../../../core/services/user_auth_service/user_auth_service.dart';
import '../../profile/shared/state_holders/profile_state.dart';
import '../state_holders/product_state.dart';

class ProductDetailsViewHelper {
  static Future<void> loadProductDetails(
      {required ProductState productState,
      required BuildContext context,
      required int productId}) async {
    bool status = await productState.getProductDetails(productId);
    if (!status && context.mounted && productState.response is Failure) {
      InternetServiceError.showErrorSnackBar(
        failure: productState.response as Failure,
        context: context,
      );
    }
  }

  static Future<void> addToCart(
      {required CartViewState cartViewState,
      required ProductState productState,
      required int productId,
      required BuildContext context}) async {
    bool isAuthenticated =
        await UserAuthService.isUserAuthenticated(futureExecution: (token) {
      addToCart(
          cartViewState: cartViewState,
          productState: productState,
          context: context,
          productId: productId);
    });
    if (!isAuthenticated) {
      return;
    }
    bool status = await cartViewState.createCartList(
      productId: productId,
      token: Get.find<ProfileState>().token,
    );
    if (!status && context.mounted) {
      Failure failure = cartViewState.response as Failure;
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
      return;
    }
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick == 3) {
        productState.setIsItemAddedToCart = false;
        timer.cancel();
      }
    });
  }
}
