import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationLoader extends StatelessWidget {
  final String asset;
  final BoxFit boxFit;
  final bool repeat;
  final double width;
  const AnimationLoader({
    super.key,
    required this.asset,
    required this.boxFit,
    required this.repeat, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      asset,
      fit: boxFit,
      width: width,
      repeat: repeat,
      renderCache: RenderCache.drawingCommands,
    );
  }
}
