import 'package:crafty_bay/common/services/internet_service_error.dart';
import 'package:crafty_bay/common/services/response/failure.dart';
import 'package:crafty_bay/common/view_model/profile_view_model.dart';
import 'package:crafty_bay/common/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/common/widgets/view_footer.dart';
import 'package:crafty_bay/features/cart/view_model/cart_view_model.dart';
import 'package:crafty_bay/features/cart/widgets/cart_footer_button.dart';
import 'package:crafty_bay/features/cart/widgets/cart_footer_text.dart';
import 'package:crafty_bay/features/cart/widgets/cart_list_card.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:crafty_bay/wrappers/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../common/widgets/alternative_widget.dart';
import '../../../common/widgets/circular_loading.dart';
import '../../../utils/app_assets.dart';
import '../../../wrappers/svg_image_loader.dart';

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
    return Scaffold(
      appBar: craftyAppBar(
        title: AppStrings.cartViewHeader,
      ),
      body: GetBuilder<CartViewModel>(
        builder: (cartViewModel) {
          if (cartViewModel.isBusy) {
            return const Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularLoading()),
              ],
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
                      cartProductData: cartViewModel.cartList[index],
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
              const Expanded(
                child: ViewFooter(
                  leftWidget: CartFooterText(),
                  rightWidget: CartFooterButton(),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> deleteCartItem(int cartId, int index) async {
    CartViewModel cartViewModel = Get.find<CartViewModel>();
    bool status = await cartViewModel.deleteCartItem(
      cartId: cartId,
      token: Get.find<ProfileViewModel>().token,
      deleteIndex: index,
    );
    if (status && mounted) {
      AppSnackBar.show(
        message: AppStrings.cartDeletionSuccessText,
        context: context,
        isError: false,
      );
      return;
    }
    Failure failure = cartViewModel.deleteResponse as Failure;
    if (mounted) {
      if (failure.statusCode != 600 ||
          failure.statusCode != 601 ||
          failure.statusCode != 501) {
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
    CartViewModel cartViewModel = Get.find<CartViewModel>();
    if (cartViewModel.cartList.isNotEmpty) {
      return;
    }
    bool status = await cartViewModel.getCartList(
      Get.find<ProfileViewModel>().token,
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
