import 'package:crafty_bay/utils/app_routes.dart';
import 'package:flutter/material.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: (RouteSettings routeSettings) {
        return AppRoutes.generateRoutes(routeSettings);
      },
    );
  }
}
