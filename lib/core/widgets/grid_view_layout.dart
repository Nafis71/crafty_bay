import 'package:flutter/material.dart';

class GridViewLayout extends StatelessWidget {
  final int length;
  final Function(dynamic) child;
  final double mainAxisExtent, crossAxisExtent;
  final bool shrinkWrap, disableScroll;

  const GridViewLayout({
    super.key,
    required this.length,
    required this.child,
    required this.mainAxisExtent,
    required this.crossAxisExtent,
    this.shrinkWrap = false,
    this.disableScroll = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: (disableScroll) ? NeverScrollableScrollPhysics() : null,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      itemCount: length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: crossAxisExtent,
        childAspectRatio: 1,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: (context, index) {
        return child(index);
      },
    );
  }
}
