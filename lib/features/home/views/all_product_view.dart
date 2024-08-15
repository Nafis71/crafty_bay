import 'package:crafty_bay/features/home/widgets/product_card.dart';
import 'package:crafty_bay/widgets/crafty_app_bar.dart';
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
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: widget.elementList.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 200,
        ),
        itemBuilder: (context, index) {
          return ProductCard(productList: widget.elementList[index]);
        },
      ),
    );
  }
}
