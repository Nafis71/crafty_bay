import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/core/services/internet_service_error.dart';
import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/features/cart/models/cart_list_model/cart_data.dart';
import 'package:crafty_bay/features/cart/models/cart_list_model/cart_product_data.dart';
import 'package:crafty_bay/features/cart/widgets/loading_dialog.dart';
import 'package:crafty_bay/features/product_details/views/product_details_view/product_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/state_holders/profile_state.dart';
import '../../../core/themes/theme_switcher.dart';
import '../../../core/widgets/small_icon_card.dart';
import '../state_holders/cart_view_state.dart';

class CartListCard extends StatelessWidget {
  final CartData cartData;
  final CartProductData productData;
  final int index;
  final void Function(int, int) onDeletePressed;

  const CartListCard({
    super.key,
    required this.cartData,
    required this.index,
    required this.onDeletePressed,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsView(
              productId: cartData.productId!,
            ),
          ),
        );
      },
      child: GetBuilder<ThemeSwitcher>(builder: (themeSwitcher) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            color: themeSwitcher.getComponentColor(),
            borderRadius: BorderRadius.circular(10),
            border: Border.fromBorderSide(
                BorderSide(color: Colors.black.withOpacity(0.03))),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CachedNetworkImage(
                  imageUrl: productData.image.toString(),
                  fit: BoxFit.contain,
                ),
              ),
              const Gap(15),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Text(
                            productData.title.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              onDeletePressed(cartData.productId!, index);
                            },
                            child: const Icon(
                              CupertinoIcons.delete_simple,
                              color: Colors.grey,
                              size: 23,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "Color: ${cartData.color}, Size: ${cartData.size}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12,
                          ),
                    ),
                    const Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${cartData.price}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                updateCartItem(
                                    isIncrement: false, context: context);
                              },
                              child: const SmallIconCard(
                                icon: Icons.remove,
                                applyPrimaryColor: false,
                                cardInsidePadding: 5,
                              ),
                            ),
                            const Gap(2),
                            GetBuilder<CartViewState>(
                              builder: (productViewModel) {
                                return Text(
                                  cartData.qty.toString().padLeft(2, "0"),
                                  style: Theme.of(context).textTheme.titleSmall,
                                );
                              },
                            ),
                            const Gap(2),
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                updateCartItem(
                                    isIncrement: true, context: context);
                              },
                              child: const SmallIconCard(
                                icon: Icons.add,
                                applyPrimaryColor: true,
                                cardInsidePadding: 5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> updateCartItem(
      {required bool isIncrement, required BuildContext context}) async {
    if (!isIncrement && int.parse(cartData.qty!) <= 1) {
      return;
    }
    BuildContext? alertDialogContext;
    alertDialogContext = await LoadingDialog.show(
      mainViewContext: context,
    );
    bool status = await Get.find<CartViewState>().updateCartList(
      index,
      Get.find<ProfileState>().token,
      isIncrement,
    );
    if (!status && context.mounted) {
      Failure failure = Get.find<CartViewState>().response as Failure;
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
    }
    Navigator.pop(alertDialogContext);
  }
}
