import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppColor.appPrimaryColor,
      strokeWidth: 2,
    );
  }
}
