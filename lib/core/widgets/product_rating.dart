import 'package:flutter/material.dart';

import '../themes/app_color.dart';

class ProductRating extends StatelessWidget {
  final double productRating, iconSize, fontSize;

  const ProductRating({
    super.key,
    required this.productRating,
    required this.iconSize,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: iconSize,
          color: AppColor.ratingIconColor,
        ),
        Text(
          productRating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: fontSize,
                color: Colors.grey.shade600,
              ),
        ),
      ],
    );
  }
}
