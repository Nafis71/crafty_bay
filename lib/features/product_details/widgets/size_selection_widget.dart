import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SizeSelectionWidget extends StatelessWidget {
  final ProductViewModel productViewModel;
  final int index;

  const SizeSelectionWidget({
    super.key,
    required this.productViewModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            productViewModel.setSelectedSize = index;
          },
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: (productViewModel.selectedSize != index)
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              border: (productViewModel.selectedSize != index)
                  ? Border.fromBorderSide(
                      BorderSide(
                          color: Colors.black.withOpacity(0.5), width: 1.8),
                    )
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              productViewModel.getSizeText(index),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: (productViewModel.selectedSize != index)
                        ? null
                        : Colors.white,
                  ),
            ),
          ),
        ),
        const Gap(15),
      ],
    );
  }
}
