import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFooter extends StatelessWidget {
  const ProductFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductViewModel>(builder: (productViewModel) {
      return Container(
        height: 100,
        padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
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
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${productViewModel.productData!.price}",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: (productViewModel.productData!.stock != 0)
                      ? ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            AppStrings.addToCartButtonText,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  fontSize: 13,
                                ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Stock out",
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
}
