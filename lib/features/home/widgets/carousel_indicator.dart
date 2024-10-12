import 'package:crafty_bay/features/home/state_holders/offer_carousel_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselIndicator extends StatelessWidget {
  final int index;

  const CarouselIndicator({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferCarouselState>(
      builder: (offerCarouselState) {
        return Container(
          height: 15,
          width: 15,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: (offerCarouselState.carouselIndex != index)
                ? Border.fromBorderSide(
                    BorderSide(color: Colors.grey.shade300, width: 1),
                  )
                : null,
            color: (offerCarouselState.carouselIndex == index)
                ? Theme.of(context).primaryColor
                : Colors.white,
          ),
        );
      },
    );
  }
}
