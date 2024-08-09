import 'package:crafty_bay/features/authentication_screens/login_screen/login_screen.dart';
import 'package:crafty_bay/features/authentication_screens/otp_verification_screen/otp_verification_screen.dart';
import 'package:crafty_bay/features/authentication_screens/profile_detail_screen/profile_detail_screen.dart';
import 'package:crafty_bay/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreen = "splashScreen";
  static const String loginScreen = "loginScreen";
  static const String otpVerificationScreen = "otpVerificationScreen";
  static const String profileDetailScreen = "profileDetailScreen";

  static MaterialPageRoute? generateRoutes(RouteSettings routeSettings) {
    Map<String, WidgetBuilder> routes = {
      AppRoutes.splashScreen: (context) => const SplashScreen(),
      AppRoutes.loginScreen: (context) => const LoginScreen(),
      AppRoutes.otpVerificationScreen: (context) {
        String emailAddress = routeSettings.arguments as String;
        return  OtpVerificationScreen(emailAddress: emailAddress,);
      },
      AppRoutes.profileDetailScreen: (context) => const ProfileDetailScreen(),
    };
    WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}
