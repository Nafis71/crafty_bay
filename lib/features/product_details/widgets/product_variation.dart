import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:crafty_bay/features/product_details/widgets/color_selection_widget.dart';
import 'package:crafty_bay/features/product_details/widgets/size_selection_widget.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductVariation extends StatelessWidget {
  final List<String> productSizes;
  final List<int> productColors;

  const ProductVariation({
    super.key,
    required this.productSizes,
    required this.productColors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.productColorHeader,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 17),
          ),
          const Gap(10),
          GetBuilder<ProductViewModel>(builder: (productViewModel) {
            return Row(
              children: List.generate(
                productColors.length,
                (index) {
                  int color = productColors[index];
                  return ColorSelectionWidget(
                    productViewModel: productViewModel,
                    index: index,
                    color: color,
                  );
                },
              ),
            );
          }),
          const Gap(15),
          Text(
            AppStrings.productSizeHeader,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 17),
          ),
          const Gap(10),
          GetBuilder<ProductViewModel>(
            builder: (productViewModel) {
              return Row(
                children: List.generate(
                  productSizes.length,
                  (index) {
                    return SizeSelectionWidget(
                      productViewModel: productViewModel,
                      index: index,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
