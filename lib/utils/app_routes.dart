import 'package:crafty_bay/features/authentication/views/login_view/login_view.dart';
import 'package:crafty_bay/features/authentication/views/otp_verification_view/otp_verification_view.dart';
import 'package:crafty_bay/features/authentication/views/profile_detail_view/profile_detail_screen.dart';
import 'package:crafty_bay/features/base_navigation/views/base_navigation_view.dart';
import 'package:flutter/material.dart';
import '../features/onboarding/views/splash_view/splash_view.dart';

class AppRoutes {
  static const String splashView = "splashScreen";
  static const String loginView = "loginScreen";
  static const String otpVerificationView = "otpVerificationScreen";
  static const String profileDetailView = "profileDetailScreen";
  static const String baseNavigationView = "mainNavigationView";

  static MaterialPageRoute? generateRoutes(RouteSettings routeSettings) {
    Map<String, WidgetBuilder> routes = {
      AppRoutes.splashView: (context) => const SplashView(),
      AppRoutes.loginView: (context) => const LoginView(),
      AppRoutes.otpVerificationView: (context) {
        String emailAddress = routeSettings.arguments as String;
        return OtpVerificationView(
          emailAddress: emailAddress,
        );
      },
      AppRoutes.profileDetailView: (context) => const ProfileDetailView(),
      AppRoutes.baseNavigationView: (context) => const BaseNavigationView(),
    };
    WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}
