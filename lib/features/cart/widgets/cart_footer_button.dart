import 'package:crafty_bay/features/cart/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartFooterButton extends StatelessWidget {
  const CartFooterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(builder: (cartViewModel){
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
