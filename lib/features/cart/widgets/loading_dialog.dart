import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/utils/app_assets.dart';

class LoadingDialog {
  static Future<BuildContext> show(
      {required BuildContext mainViewContext}) async {
    BuildContext? alertDialogContext;
    showDialog(
      context: mainViewContext,
      barrierColor: Colors.black.withOpacity(0.05),
      barrierDismissible: false,
      builder: (alertContext) {
        alertDialogContext = alertContext;
        return SizedBox(
          child: FittedBox(
            child: AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
              content: Center(
                  child: Lottie.asset(AppAssets.cartLottie,
                      fit: BoxFit.contain, width: 70, height: 60)),
            ),
          ),
        );
      },
    );
    await Future.delayed(Duration(milliseconds: 420));
    return alertDialogContext!;
  }
}
