import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:crafty_bay/core/utils/product_rating_calculator.dart';
import 'package:crafty_bay/features/product_review/models/product_review_model/product_review_model.dart';
import 'package:crafty_bay/features/product_review/widgets/product_review_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/themes/app_color.dart';
import '../../../core/themes/theme_switcher.dart';

class ProductReviewCard extends StatelessWidget {
  final ProductReviewModel productReviewData;

  const ProductReviewCard({super.key, required this.productReviewData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeSwitcher>(builder: (themeSwitcher) {
      return Container(
        padding: const EdgeInsets.all(25),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.appBarActionButtonColorLight,
                  child: const Icon(
                    CupertinoIcons.person,
                    color: Colors.grey,
                  ),
                ),
                const Gap(10),
                Text(
                  (productReviewData.profile!.cusName != null)
                      ? "${productReviewData.profile!.cusName}"
                      : AppStrings.unknownUserText,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 17),
                )
              ],
            ),
            const Gap(8),
            Text(
              productReviewData.description!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 13),
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProductReviewRatingBar.show(
                  initialRating: ProductRatingCalculator()
                      .getProductRating(productReviewData.rating!),
                  onlyReadable: true
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
