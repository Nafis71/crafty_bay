import 'package:crafty_bay/app/initiate_states.dart';
import 'package:crafty_bay/core/utils/app_routes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/themes/app_theme.dart';
import '../core/themes/theme_switcher.dart';

class CraftyBay extends StatefulWidget {
  final bool? isDarkModeEnabled;

  const CraftyBay({super.key, this.isDarkModeEnabled});

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
  late final GlobalKey<NavigatorState> navigatorState;

  @override
  void initState() {
    navigatorState = GlobalKey<NavigatorState>();
    loadTheme(widget.isDarkModeEnabled);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeSwitcher>(builder: (themeSwitcher) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorState,
        initialBinding: InitiateViewModel(),
        initialRoute: AppRoutes.splashView,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        onGenerateRoute: (RouteSettings routeSettings) {
          return AppRoutes.generateRoutes(routeSettings);
        },
        themeMode: themeSwitcher.themeMode,
        theme: AppTheme.getLightTheme(),
        darkTheme: AppTheme.getDarkTheme(),
      );
    });
  }

  Future<void> loadTheme(bool? isDarkModeEnabled) async {
    if (isDarkModeEnabled != null && isDarkModeEnabled) {
      Get.find<ThemeSwitcher>().setThemeModeSilently = ThemeMode.dark;
    }
  }
}
