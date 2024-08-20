import 'package:crafty_bay/features/cart/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartFooterText extends StatelessWidget {
  final int totalPrice;

  const CartFooterText({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      builder: (cartViewModel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Price",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    fontFamily: "Poppins Medium",
                    color: Colors.black.withOpacity(0.5),
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
