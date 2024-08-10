import 'package:crafty_bay/app/initiate_controller.dart';
import 'package:crafty_bay/themes/app_theme.dart';
import 'package:crafty_bay/utils/app_routes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitiateController(),
      initialRoute: AppRoutes.splashView,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      onGenerateRoute: (RouteSettings routeSettings) {
        return AppRoutes.generateRoutes(routeSettings);
      },
      themeMode: ThemeMode.light,
      theme: AppTheme.getLightTheme(),
    );
  }
}
