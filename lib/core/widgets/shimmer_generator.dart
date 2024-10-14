import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../themes/app_color.dart';
import '../themes/theme_switcher.dart';

class ShimmerGenerator extends StatelessWidget {
  final Widget shimmer;
  final Axis axis;
  final int itemCount;
  final double shimmerHeight;

  const ShimmerGenerator(
      {super.key,
      required this.shimmer,
      required this.axis,
      required this.itemCount,
      required this.shimmerHeight});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeSwitcher>(builder: (themeSwitcher) {
      return SizedBox(
        height: shimmerHeight,
        child: Shimmer.fromColors(
          baseColor: (themeSwitcher.themeMode == ThemeMode.light)
              ? Colors.grey.shade100
              : AppColor.darkComponentsColor,
          highlightColor: (themeSwitcher.themeMode == ThemeMode.light)
              ? Colors.white
              : Colors.white.withOpacity(0.01),
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: axis,
            itemBuilder: (context, index) {
              return shimmer;
            },
            separatorBuilder: (BuildContext context, int index) {
              return Gap(10);
            },
            itemCount: itemCount,
          ),
        ),
      );
    });
  }
}
