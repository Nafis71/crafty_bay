import 'dart:async';

import 'package:crafty_bay/common/widgets/circular_loading.dart';
import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFooter extends StatelessWidget {
  final Function(dynamic) addToCart;

  const ProductFooter({super.key, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductViewModel>(builder: (productViewModel) {
      return Container(
        height: 100,
        padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.appSecondaryColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.productPriceHeader,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "\$${productViewModel.productData!.price}",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.38,
                  height: 50,
                  child: (productViewModel.productData!.stock != 0)
                      ? GetBuilder<ProductViewModel>(
                          builder: (productViewModel) {
                            if (productViewModel.isAddingToCart) {
                              return const Center(
                                child: CircularLoading(),
                              );
                            }
                            if (productViewModel.isItemAddedToCart) {

                              return Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Theme.of(context).primaryColor,
                                      size: 35,
                                    ),
                                    Text(
                                      "Added",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              );
                            }
                            return ElevatedButton(
                              onPressed: () => addToCart(productViewModel),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                AppStrings.addToCartButtonText,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(fontSize: 13),
                              ),
                            );
                          },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              AppStrings.stockOutText,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.redAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
  // void resetAddToCartButton(ProductViewModel productViewModel){
  //
  // }
}
