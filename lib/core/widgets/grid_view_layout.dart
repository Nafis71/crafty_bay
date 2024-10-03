import 'package:flutter/material.dart';

class GridViewLayout extends StatelessWidget {
  final int length;
  final Function(dynamic) child;

  const GridViewLayout({
    super.key,
    required this.length,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        childAspectRatio: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 200,
      ),
      itemBuilder: (context, index) {
        return child(index);
      },
    );
  }
}
