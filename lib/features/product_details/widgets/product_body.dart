import 'package:crafty_bay/features/product_details/models/product.dart';
import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:crafty_bay/features/product_details/widgets/small_icon_card.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../themes/app_color.dart';

class ProductBody extends StatelessWidget {
  final Product product;

  const ProductBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  product.title.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 18),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Get.find<ProductViewModel>().decrementProductQuantity();
                      },
                      child: const SmallIconCard(
                        icon: Icons.remove,
                        applyPrimaryColor: false,
                      ),
                    ),
                    const Gap(2),
                    GetBuilder<ProductViewModel>(
                      builder: (productViewModel) {
                        return Text(
                          productViewModel.productQuantity.toString(),
                          style: Theme.of(context).textTheme.titleSmall,
                        );
                      },
                    ),
                    const Gap(2),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Get.find<ProductViewModel>().incrementProductQuantity();
                      },
                      child: const SmallIconCard(
                        icon: Icons.add,
                        applyPrimaryColor: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: 28,
                color: AppColor.ratingIconColor,
              ),
              Text(
                product.star.toString(),
                style: Theme.of(context).textTheme.labelSmall!,
              ),
              const Gap(15),
              Text(
                AppStrings.productReviewHeader,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Gap(15),
              const SmallIconCard(
                icon: Icons.favorite_outline_rounded,
                applyPrimaryColor: true,
              )
            ],
          )
        ],
      ),
    );
  }
}
