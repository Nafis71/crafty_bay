import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImageLoader extends StatelessWidget {
  final String assetLocation;
  final BoxFit boxFit;
  final double? width, height;

  const SvgImageLoader(
      {super.key,
      required this.assetLocation,
      required this.boxFit,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetLocation,
      fit: boxFit,
      width: width,
      height: height,
    );
  }
}
