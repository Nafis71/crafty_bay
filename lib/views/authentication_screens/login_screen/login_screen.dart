import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_assets.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:crafty_bay/wrappers/svg_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SvgImageLoader(
                  assetLocation: AppAssets.appLogo,
                  boxFit: BoxFit.contain,
                  width: 120,
                ),
                const Gap(30),
                Text(AppStrings.loginScreenTitle,
                    style: Theme.of(context).textTheme.titleLarge),
                const Gap(5),
                Text(AppStrings.loginScreenDescription,
                    style: Theme.of(context).textTheme.titleMedium),
                const Gap(10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: AppColor.appPrimaryColor,
                          decoration:
                              const InputDecoration(hintText: AppStrings.emailTextFieldHintText),
                        ),
                        const Gap(20),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(onPressed: (){}, child: const Text(AppStrings.loginScreenButtonText)))
                      ],
                    ),
                  ),
                ),
                if(deviceOrientation != Orientation.landscape) const Gap(120)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
