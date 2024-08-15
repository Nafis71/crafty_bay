import 'package:flutter/material.dart';

class AllProductView extends StatefulWidget {
  final List<dynamic> elementList;
  const AllProductView({super.key, required this.elementList});

  @override
  State<AllProductView> createState() => _AllProductViewState();
}

class _AllProductViewState extends State<AllProductView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("This is all product screen"),),
    );
  }
}
