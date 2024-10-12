import 'package:crafty_bay/features/cart/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/circular_loading.dart';
import '../view_models/product_view_model.dart';

class ProductDetailsFooterButton extends StatelessWidget {
  final Function(dynamic) addToCart;

  const ProductDetailsFooterButton({super.key, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductViewModel>(
      builder: (productViewModel) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.38,
          height: 50,
          child: (productViewModel.productData!.stock != 0)
              ? Builder(
                  builder: (context) {
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
                                  .copyWith(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () => addToCart(Get.find<CartViewModel>()),
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.redAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
