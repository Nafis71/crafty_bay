import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_strings.dart';
import '../state_holders/product_state.dart';

class ProductDetailsFooterText extends StatelessWidget {
  const ProductDetailsFooterText({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductState>(
      builder: (productState) {
        return Column(
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
              "\$${productState.productData!.price}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
            ),
          ],
        );
      },
    );
  }
}
