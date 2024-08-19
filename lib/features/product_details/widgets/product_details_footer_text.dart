import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings.dart';

class ProductDetailsFooterText extends StatelessWidget {
  const ProductDetailsFooterText({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductViewModel>(
      builder: (productViewModel) {
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
              "\$${productViewModel.productData!.price}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 17),
            ),
          ],
        );
      },
    );
  }
}
