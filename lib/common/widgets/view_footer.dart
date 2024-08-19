import 'package:flutter/material.dart';

import '../../themes/app_color.dart';

class ViewFooter extends StatelessWidget {
  final Widget leftWidget, rightWidget;

  const ViewFooter({
    super.key,
    required this.leftWidget,
    required this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
      decoration: BoxDecoration(
        color: AppColor.appSecondaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  leftWidget
                ],
              ),
              rightWidget
            ],
          ),
        ],
      ),
    );
  }
}
