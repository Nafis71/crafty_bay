import 'package:crafty_bay/features/authentication/views/login_view/login_view.dart';
import 'package:crafty_bay/features/authentication/views/otp_verification_view/otp_verification_view.dart';
import 'package:crafty_bay/features/authentication/views/profile_detail_view/profile_detail_screen.dart';
import 'package:crafty_bay/features/base_navigation/views/base_navigation_view.dart';
import 'package:flutter/material.dart';

import '../features/onboarding/views/splash_view/splash_view.dart';

class AppRoutes {
  static const String splashView = "/";
  static const String loginView = "/loginScreen";
  static const String otpVerificationView = "/otpVerificationScreen";
  static const String profileDetailView = "/profileDetailScreen";
  static const String baseNavigationView = "/mainNavigationView";

  static PageRoute? generateRoutes(RouteSettings routeSettings) {
    Map<String, WidgetBuilder> routes = {
      AppRoutes.splashView: (context) => const SplashView(),
      AppRoutes.loginView: (context) {
        Function(dynamic) futureExecution =
            routeSettings.arguments as Function(dynamic);
        return LoginView(
          futureExecution: futureExecution,
        );
      },
      AppRoutes.otpVerificationView: (context) {
        Map<String, dynamic> viewData =
            routeSettings.arguments as Map<String, dynamic>;
        return OtpVerificationView(
          viewData: viewData,
        );
      },
      AppRoutes.profileDetailView: (context) => const ProfileDetailView(),
      AppRoutes.baseNavigationView: (context) => const BaseNavigationView(),
    };
    WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}
