import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state_holders/cart_view_state.dart';

class CartFooterButton extends StatelessWidget {
  const CartFooterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewState>(builder: (cartViewModel) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            "Checkout",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 13, color: Colors.white),
          ),
        ),
      );
    });
  }
}
