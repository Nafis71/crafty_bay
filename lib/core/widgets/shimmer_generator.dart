import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGenerator extends StatelessWidget {
  final Widget shimmer;
  final Axis axis;
  final int itemCount;
  final double shimmerHeight;

  const ShimmerGenerator(
      {super.key, required this.shimmer, required this.axis, required this.itemCount, required this.shimmerHeight});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: shimmerHeight,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.white,
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
  }
}
