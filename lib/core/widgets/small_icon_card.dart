import 'package:flutter/material.dart';

import '../themes/app_color.dart';

class SmallIconCard extends StatelessWidget {
  final IconData icon;
  final bool applyPrimaryColor;
  final double cardInsidePadding;

  const SmallIconCard({
    super.key,
    required this.icon,
    required this.applyPrimaryColor,
    required this.cardInsidePadding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: (applyPrimaryColor)
          ? Theme.of(context).primaryColor
          : AppColor.quantityDecreaseCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.all(cardInsidePadding),
        child: Icon(icon, color: Colors.white, size: 15),
      ),
    );
  }
}
