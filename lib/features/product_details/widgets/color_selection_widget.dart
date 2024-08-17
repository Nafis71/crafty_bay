import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ColorSelectionWidget extends StatelessWidget {
  final ProductViewModel productViewModel;
  final int index;
  final int color;

  const ColorSelectionWidget(
      {super.key,
      required this.productViewModel,
      required this.index,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            productViewModel.setSelectedColor = index;
          },
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Color(color),
            child: (index == productViewModel.selectedColor)
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
