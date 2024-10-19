import 'package:flutter/material.dart';

import '../../../../core/wrappers/animation_loader.dart';

class PaymentStatus extends StatelessWidget {
  final String animationAsset;
  final String headerText, subtitleText;

  const PaymentStatus(
      {super.key,
      required this.animationAsset,
      required this.headerText,
      required this.subtitleText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimationLoader(
                  asset: animationAsset,
                  boxFit: BoxFit.contain,
                  repeat: false,
                  width: 280,
                ),
                Positioned(
                  top: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        headerText,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          subtitleText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
