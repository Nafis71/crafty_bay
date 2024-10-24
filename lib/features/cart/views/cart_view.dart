import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/core/widgets/login_prompt.dart';
import 'package:crafty_bay/core/widgets/shimmer_generator.dart';
import 'package:crafty_bay/core/widgets/view_footer.dart';
import 'package:crafty_bay/features/cart/utils/cart_view_helper.dart';
import 'package:crafty_bay/features/cart/utils/cart_view_strings.dart';
import 'package:crafty_bay/features/cart/widgets/cart_footer_button.dart';
import 'package:crafty_bay/features/cart/widgets/cart_footer_text.dart';
import 'package:crafty_bay/features/cart/widgets/cart_list_card.dart';
import 'package:crafty_bay/features/cart/widgets/cart_view_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/alternative_widget.dart';
import '../../../core/wrappers/svg_image_loader.dart';
import '../../profile/shared/state_holders/profile_state.dart';
import '../state_holders/cart_view_state.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    CartViewHelper.getCartList(
      cartViewState: Get.find<CartViewState>(),
      profileState: Get.find<ProfileState>(),
      context: context,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    Orientation orientation = MediaQuery.orientationOf(context);
    return Scaffold(
      appBar: craftyAppBar(
        title: CartViewStrings.cartViewHeader,
      ),
      body: GetBuilder<CartViewState>(
        builder: (cartViewModel) {
          if (Get.find<ProfileState>().token.isEmpty) {
            return LoginPrompt(
              subtitle: CartViewStrings.cartLoginText,
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
                CartViewHelper.getCartList(
                  cartViewState: Get.find<CartViewState>(),
                  profileState: Get.find<ProfileState>(),
                  context: context,
                );
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
                CartViewHelper.getCartList(
                  cartViewState: Get.find<CartViewState>(),
                  profileState: Get.find<ProfileState>(),
                  context: context,
                );
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
                    CartViewStrings.noCartListFoundText,
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                flex: (orientation == Orientation.portrait) ? 6 : 2,
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  itemBuilder: (_, index) {
                    return CartListCard(
                      cartData: cartViewModel.cartList[index],
                      productData:
                          cartViewModel.cartList[index].cartProductData!,
                      index: index,
                      onDeletePressed: (int cardId, int index) {
                        CartViewHelper.deleteCartItem(
                          cartId: cardId,
                          index: index,
                          cartViewState: Get.find<CartViewState>(),
                          profileState: Get.find<ProfileState>(),
                          context: context,
                        );
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
}
