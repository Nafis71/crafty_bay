import 'package:crafty_bay/features/product_review/models/product_review_model/product_review_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../themes/app_color.dart';

class ProductReviewCard extends StatelessWidget {
  final ProductReviewModel productReviewData;

  const ProductReviewCard({super.key, required this.productReviewData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColor.appBarActionButtonColor,
                child: const Icon(
                  CupertinoIcons.person,
                  color: Colors.grey,
                ),
              ),
              const Gap(10),
              Text(
                "${productReviewData.profile!.firstName} ${productReviewData.profile!.lastName}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 17),
              )
            ],
          ),
          const Gap(8),
          Text(productReviewData.description!,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 13
          ),)
        ],
      ),
    );
  }
}