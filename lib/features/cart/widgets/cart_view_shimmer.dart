import 'package:flutter/material.dart';

class CartViewShimmer extends StatelessWidget {
  const CartViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      height: 200,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
