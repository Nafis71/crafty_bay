import 'package:crafty_bay/themes/app_theme.dart';
import 'package:crafty_bay/utils/app_routes.dart';
import 'package:crafty_bay/views/authentication_screens/otp_verification_screen/countdown_timer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> CountdownTimer(),lazy: true,),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        onGenerateRoute: (RouteSettings routeSettings) {
          return AppRoutes.generateRoutes(routeSettings);
        },
        themeMode: ThemeMode.light,
        theme: AppTheme.getLightTheme(),
      ),
    );
  }
}
