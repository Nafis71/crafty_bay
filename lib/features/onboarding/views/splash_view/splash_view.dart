import 'package:crafty_bay/core/services/prefetch_service.dart';
import 'package:crafty_bay/core/utils/app_assets.dart';
import 'package:crafty_bay/core/utils/app_routes.dart';
import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:crafty_bay/core/widgets/circular_loading.dart';
import 'package:crafty_bay/features/cart/state_holders/cart_view_state.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../../../core/state_holders/connection_state.dart';
import '../../../../core/state_holders/profile_state.dart';
import '../../../../core/wrappers/app_snack_bar.dart';
import '../../../../core/wrappers/svg_image_loader.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isLoading = false;
  bool hasShownSnackBar = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NetworkState>(builder: (networkState) {
        if (networkState.hasInternet) {
          _prefetchData();
        } else {
          if (!hasShownSnackBar) {
            hasShownSnackBar = true;
            Future.delayed(
              const Duration(seconds: 3),
              () {
                if (context.mounted && !networkState.hasInternet) {
                  AppSnackBar.show(
                    message: AppStrings.networkError,
                    context: context,
                    isError: true,
                    color: Colors.black,
                  );
                }
              },
            );
          }
        }
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                    duration: const Duration(seconds: 2),
                  ),
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
        );
      }),
    );
  }

  Future<void> _prefetchData() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    if (!await Get.find<ProfileState>().isTokenExpired()) {
      await PrefetchService.prefetchProductWishList(
        Get.find<ProfileState>().token,
      );
      await Get.find<CartViewState>().getCartList(
        Get.find<ProfileState>().token,
      );
    }else{
      await Future.delayed(Duration(seconds: 3));
    }
    await Get.find<ProfileState>().loadUserDataFromStorage();
    Navigator.pushNamed(context, AppRoutes.baseNavigationView);
  }
}
