import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/core/widgets/grid_view_layout.dart';
import 'package:crafty_bay/core/widgets/product_card.dart';
import 'package:flutter/material.dart';

class AllProductView extends StatefulWidget {
  final List<dynamic> elementList;
  final String appBarTitle;

  const AllProductView(
      {super.key, required this.elementList, required this.appBarTitle});

  @override
  State<AllProductView> createState() => _AllProductViewState();
}

class _AllProductViewState extends State<AllProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(title: widget.appBarTitle, context: context),
      body: GridViewLayout(
        length: widget.elementList.length,
        mainAxisExtent: 200,
        crossAxisExtent: 200,
        child: (index) {
          return ProductCard(
            productList: widget.elementList[index],
            isWishListCard: false,
          );
        },
      ),
    );
  }
}
