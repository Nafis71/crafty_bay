import 'package:flutter/material.dart';

class ProductReviewShimmer extends StatelessWidget {
  const ProductReviewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      height: 100,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
