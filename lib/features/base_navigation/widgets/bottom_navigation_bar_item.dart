import 'package:flutter/material.dart';

import '../../../core/wrappers/svg_image_loader.dart';

BottomNavigationBarItem getBottomNavigationBarItem({
  required int index,
  required int targetIndex,
  required BuildContext context,
  required String label,
  required String iconPath,
}) =>
    BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Column(
          children: [
            SvgImageLoader(
              assetLocation: iconPath,
              boxFit: BoxFit.cover,
              width: 32,
              color: (index == targetIndex)
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
          ],
        ),
      ),
      label: label,
    );
