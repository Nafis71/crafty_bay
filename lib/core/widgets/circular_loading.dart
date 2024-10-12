import 'package:flutter/material.dart';

import '../themes/app_color.dart';

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
