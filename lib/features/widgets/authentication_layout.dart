import 'package:crafty_bay/features/authentication_screens/view_model/auth_view_model.dart';
import 'package:crafty_bay/features/widgets/circular_loading.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_strings.dart';
import '../../wrappers/svg_image_loader.dart';

class AuthenticationLayout extends StatelessWidget {
  final double imageWidth = 120;
  final String titleText, descriptionText;
  final Widget formWidget;
  final Orientation deviceOrientation;
  final Widget? bottomWidget;
  final Function onButtonPressed;
  final String? buttonText;

  const AuthenticationLayout({
    super.key,
    required this.titleText,
    required this.descriptionText,
    required this.formWidget,
    required this.deviceOrientation,
    this.bottomWidget,
    required this.onButtonPressed,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgImageLoader(
          assetLocation: AppAssets.appLogo,
          boxFit: BoxFit.contain,
          width: imageWidth,
        ),
        const Gap(30),
        Text(titleText, style: Theme.of(context).textTheme.titleLarge),
        const Gap(5),
        Text(descriptionText, style: Theme.of(context).textTheme.titleMedium),
        const Gap(10),
        formWidget,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: double.infinity,
            child: GetBuilder<AuthViewModel>(
              builder: (authViewModel) {
                if(authViewModel.isBusy){
                  return const Center(child: CircularLoading(),);
                }
                return ElevatedButton(
                  onPressed: () {
                    onButtonPressed();
                  },
                  child: Text(
                    (buttonText == null)
                        ? AppStrings.loginScreenButtonText
                        : buttonText!,
                  ),
                );
              }
            ),
          ),
        ),
        if (bottomWidget != null) const Gap(30),
        if (bottomWidget != null) bottomWidget!,
        if (deviceOrientation != Orientation.landscape && bottomWidget == null)
          const Gap(120)
      ],
    );
  }
}
