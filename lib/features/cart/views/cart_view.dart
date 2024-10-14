import 'package:crafty_bay/core/services/internet_service_error.dart';
import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/core/widgets/login_prompt.dart';
import 'package:crafty_bay/core/widgets/shimmer_generator.dart';
import 'package:crafty_bay/core/widgets/view_footer.dart';
import 'package:crafty_bay/features/cart/widgets/cart_footer_button.dart';
import 'package:crafty_bay/features/cart/widgets/cart_footer_text.dart';
import 'package:crafty_bay/features/cart/widgets/cart_list_card.dart';
import 'package:crafty_bay/features/cart/widgets/cart_view_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/state_holders/profile_state.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/alternative_widget.dart';
import '../../../core/wrappers/app_snack_bar.dart';
import '../../../core/wrappers/svg_image_loader.dart';
import '../state_holders/cart_view_state.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    getCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: craftyAppBar(
        title: AppStrings.cartViewHeader,
      ),
      body: GetBuilder<CartViewState>(
        builder: (cartViewModel) {
          if (Get.find<ProfileState>().token.isEmpty) {
            return LoginPrompt(
              subtitle: AppStrings.cartLoginText,
              futureExecution: (token) async {
                await cartViewModel.getCartList(token);
              },
            );
          }
          if (cartViewModel.isBusy) {
            return ShimmerGenerator(
              shimmer: CartViewShimmer(),
              axis: Axis.vertical,
              itemCount: 8,
              shimmerHeight: size.height,
            );
          }
          if (cartViewModel.response is Failure) {
            return AlternativeWidget(
              onRefresh: () {
                getCartList();
              },
              child: const SvgImageLoader(
                assetLocation: AppAssets.noInternet,
                boxFit: BoxFit.contain,
              ),
            );
          }
          if (cartViewModel.cartList.isEmpty) {
            return AlternativeWidget(
              onRefresh: () {
                getCartList();
              },
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 45,
                  ),
                  const Gap(15),
                  const Text(
                    AppStrings.noCartListFoundText,
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                flex: 6,
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  itemBuilder: (context, index) {
                    return CartListCard(
                      cartData: cartViewModel.cartList[index],
                      productData:
                          cartViewModel.cartList[index].cartProductData!,
                      index: index,
                      onDeletePressed: (int cardId, int index) {
                        deleteCartItem(cardId, index);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Gap(20);
                  },
                  itemCount: cartViewModel.cartList.length,
                ),
              ),
              Expanded(
                child: GetBuilder<CartViewState>(builder: (cartViewModel) {
                  return ViewFooter(
                    leftWidget: CartFooterText(
                      totalPrice: cartViewModel.totalPrice,
                    ),
                    rightWidget: const CartFooterButton(),
                  );
                }),
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> deleteCartItem(int cartId, int index) async {
    CartViewState cartViewModel = Get.find<CartViewState>();
    bool status = await cartViewModel.deleteCartItem(
      cartId: cartId,
      token: Get.find<ProfileState>().token,
      deleteIndex: index,
    );
    if (status && mounted) {
      return;
    }
    Failure failure = cartViewModel.deleteResponse as Failure;
    if (mounted) {
      if (failure.statusCode != 600 ||
          failure.statusCode != 601 ||
          failure.statusCode != 500) {
        AppSnackBar.show(
          message: AppStrings.cartDeletionFailureText,
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

  Future<void> getCartList() async {
    CartViewState cartViewModel = Get.find<CartViewState>();
    ProfileState profileState = Get.find<ProfileState>();
    if (await profileState.isTokenExpired()) {
      profileState.setToken = "";
      cartViewModel.update();
      return;
    }
    if (cartViewModel.cartList.isNotEmpty ||
        Get.find<ProfileState>().token.isEmpty) {
      return;
    }
    bool status = await cartViewModel.getCartList(
      Get.find<ProfileState>().token,
    );
    if (!status && mounted) {
      Failure failure = cartViewModel.response as Failure;
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
    }
  }
}
