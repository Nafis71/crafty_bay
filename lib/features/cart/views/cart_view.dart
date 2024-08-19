import 'package:crafty_bay/common/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(
        title: AppStrings.cartViewHeader,
      ),
    );
  }
}
