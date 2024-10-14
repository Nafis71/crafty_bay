import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/theme_switcher.dart';

class ProfileOptions extends StatelessWidget {
  final Widget optionTrailingWidget, optionLeadingWidget;

  const ProfileOptions(
      {super.key,
      required this.optionTrailingWidget,
      required this.optionLeadingWidget});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeSwitcher>(builder: (themeSwitcher) {
      return Card(
        color: themeSwitcher.getComponentColor(),
        shadowColor: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              optionLeadingWidget,
              optionTrailingWidget,
            ],
          ),
        ),
      );
    });
  }
}
