import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state_holders/cart_view_state.dart';

class CartFooterText extends StatelessWidget {
  final int totalPrice;

  const CartFooterText({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewState>(
      builder: (cartViewModel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Price",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              "\$$totalPrice",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ],
        );
      },
    );
  }
}
