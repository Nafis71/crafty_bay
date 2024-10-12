import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../state_holders/product_state.dart';

class ColorSelectionWidget extends StatelessWidget {
  final ProductState productState;
  final int index;
  final int color;

  const ColorSelectionWidget(
      {super.key,
      required this.productState,
      required this.index,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            productState.setSelectedColor = index;
          },
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Color(color),
            child: (index == productState.selectedColor)
                ? const Icon(
                    Icons.done,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
        const Gap(15),
      ],
    );
  }
}
