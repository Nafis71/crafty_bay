import 'package:crafty_bay/features/profile/shared/state_holders/profile_state.dart';
import 'package:flutter/material.dart';

import '../../../core/services/network_service/internet_service_error.dart';
import '../../../core/services/response/failure.dart';
import '../../../core/wrappers/app_snack_bar.dart';
import '../state_holders/cart_view_state.dart';
import 'cart_view_strings.dart';

class CartViewHelper {
  static Future<void> getCartList(
      {required CartViewState cartViewState,
      required ProfileState profileState,
      required BuildContext context}) async {
    if (await profileState.isTokenExpired()) {
      profileState.setToken = "";
      cartViewState.update();
      return;
    }
    if (cartViewState.cartList.isNotEmpty || profileState.token.isEmpty) {
      return;
    }
    bool status = await cartViewState.getCartList(
      profileState.token,
    );
    if (!status && context.mounted) {
      Failure failure = cartViewState.response as Failure;
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
    }
  }

  static Future<void> deleteCartItem(
      {required int cartId,
      required int index,
      required CartViewState cartViewState,
      required ProfileState profileState,
      required BuildContext context}) async {
    bool status = await cartViewState.deleteCartItem(
      cartId: cartId,
      token: profileState.token,
      deleteIndex: index,
    );
    if (status) {
      return;
    }
    Failure failure = cartViewState.deleteResponse as Failure;
    if (context.mounted) {
      if (failure.statusCode != 600 ||
          failure.statusCode != 601 ||
          failure.statusCode != 500) {
        AppSnackBar.show(
          message: CartViewStrings.cartDeletionFailureText,
          context: context,
          isError: true,
        );
        return;
      }
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
    }
  }
}
