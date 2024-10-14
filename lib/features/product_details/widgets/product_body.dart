import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:crafty_bay/core/utils/product_rating_calculator.dart';
import 'package:crafty_bay/core/widgets/small_icon_card.dart';
import 'package:crafty_bay/features/product_details/models/product.dart';
import 'package:crafty_bay/features/product_review/views/product_review_view/product_review_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/state_holders/profile_state.dart';
import '../../../core/themes/app_color.dart';
import '../../wish_list/state_holders/wish_list_state.dart';
import '../state_holders/product_state.dart';

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
                      .copyWith(fontSize: 17),
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
                        Get.find<ProductState>().decrementProductQuantity();
                      },
                      child: const SmallIconCard(
                        cardInsidePadding: 5,
                        icon: Icons.remove,
                        applyPrimaryColor: false,
                      ),
                    ),
                    const Gap(2),
                    GetBuilder<ProductState>(
                      builder: (productViewModel) {
                        return Text(
                          productViewModel.productQuantity
                              .toString()
                              .padLeft(2, "0"),
                          style: Theme.of(context).textTheme.titleSmall,
                        );
                      },
                    ),
                    const Gap(2),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Get.find<ProductState>().incrementProductQuantity();
                      },
                      child: const SmallIconCard(
                        cardInsidePadding: 5,
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
                ProductRatingCalculator()
                    .getProductRating(product.star ?? 0.0)
                    .toStringAsFixed(1),
                style: Theme.of(context).textTheme.labelSmall!,
              ),
              const Gap(15),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductReviewView(
                        productId: product.id!,
                      ),
                    ),
                  );
                },
                child: Text(
                  AppStrings.productReviewHeader,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Gap(15),
              GetBuilder<WishListState>(builder: (wishListState) {
                return InkWell(
                  onTap: () {
                    if (wishListState.wishListProductId.contains(product.id!)) {
                      return;
                    }
                    wishListState.createWishList(
                      product.id!,
                      Get.find<ProfileState>().token,
                    );
                  },
                  child: SmallIconCard(
                    icon:
                        (!wishListState.wishListProductId.contains(product.id!))
                            ? Icons.favorite_outline_rounded
                            : Icons.favorite,
                    applyPrimaryColor: true,
                    cardInsidePadding: 5,
                  ),
                );
              })
            ],
          )
        ],
      ),
    );
  }
}
