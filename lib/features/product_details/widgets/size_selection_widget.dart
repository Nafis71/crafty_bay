import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../state_holders/product_state.dart';

class SizeSelectionWidget extends StatelessWidget {
  final ProductState productState;
  final int index;

  const SizeSelectionWidget({
    super.key,
    required this.productState,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            productState.setSelectedSize = index;
          },
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: (productState.selectedSize != index)
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              border: (productState.selectedSize != index)
                  ? Border.fromBorderSide(
                      BorderSide(
                        color: Colors.black.withOpacity(0.5),
                        width: 0.5,
                      ),
                    )
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              productState.getSizeText(index),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: (productState.selectedSize != index)
                        ? Colors.black
                        : Colors.white,
                  ),
            ),
          ),
        ),
        const Gap(10),
      ],
    );
  }
}
