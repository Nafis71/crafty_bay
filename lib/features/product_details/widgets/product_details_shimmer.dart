import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          height: 200,
          width: size.width * 0.9,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 30,
              width: size.width * 0.6,
              margin: const EdgeInsets.only(top: 10, left: 20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              height: 30,
              width: size.width * 0.2,
              margin: const EdgeInsets.only(top: 10, right: 20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
        Row(
          children: List.generate(
            4,
            (index) {
              return Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.only(top: 10, left: 20),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        ),
        Row(
          children: List.generate(
            4,
            (index) {
              return Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.only(top: 10, left: 20),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        ),
        Gap(10),
        for (int i = 0; i < 3; i++)
          Container(
            height: 20,
            width: size.width * 0.9,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
      ],
    );
  }
}
