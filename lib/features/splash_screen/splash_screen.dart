import 'package:crafty_bay/features/widgets/circular_loading.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_assets.dart';
import 'package:crafty_bay/utils/app_routes.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:crafty_bay/wrappers/svg_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkToken();
  }

  Future<void> checkToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString("token");
    if (token == null || JwtDecoder.isExpired(token)) {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offNamed(AppRoutes.loginScreen);
      });
      return;
    }
    bool? hasUserData = localStorage.getBool("hasUserData");
    if (hasUserData == null || !hasUserData) {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offNamed(AppRoutes.profileDetailScreen);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                    duration: const Duration(seconds: 3)),
                child: const SvgImageLoader(
                  assetLocation: AppAssets.appLogo,
                  boxFit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  const CircularLoading(),
                  const Gap(20),
                  Text(
                    AppStrings.appVersion,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
