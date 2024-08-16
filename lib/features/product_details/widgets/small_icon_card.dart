import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';

class SmallIconCard extends StatelessWidget {
  final IconData icon;
  final bool applyPrimaryColor;

  const SmallIconCard({super.key, required this.icon, required this.applyPrimaryColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: (applyPrimaryColor)
          ? Theme.of(context).primaryColor
          : AppColor.quantityDecreaseCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
