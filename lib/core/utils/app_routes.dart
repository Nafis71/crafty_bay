import 'package:crafty_bay/features/base_navigation/views/base_navigation_view.dart';
import 'package:crafty_bay/features/complete_profile/views/complete_profile_view.dart';
import 'package:crafty_bay/features/payment/invoice_creation/models/payment_method.dart';
import 'package:crafty_bay/features/payment/invoice_creation/views/invoice_creation_view.dart';
import 'package:crafty_bay/features/payment/payment_webView/views/payment_webView.dart';
import 'package:crafty_bay/features/wish_list/views/wish_list_view.dart';
import 'package:flutter/material.dart';

import '../../features/authentication/login_view/views/login_view.dart';
import '../../features/authentication/otp_verification_view/views/otp_verification_view.dart';
import '../../features/onboarding/views/splash_view/splash_view.dart';
import '../../features/profile/profile_updation_view/models/profile_updation_model.dart';
import '../../features/profile/profile_updation_view/profile_updation_view.dart';
import '../../features/profile/profile_view/profile_view.dart';

class AppRoutes {
  static const String splashView = "/";
  static const String loginView = "/loginScreen";
  static const String otpVerificationView = "/otpVerificationScreen";
  static const String profileDetailView = "/profileDetailScreen";
  static const String baseNavigationView = "/mainNavigationView";
  static const String profileView = "/profileView";
  static const String wishListView = "/wishListView";
  static const String profileUpdationView = "/profileUpdationView";
  static const String invoiceCreationView = "/invoiceCreationView";
  static const String paymentWebView = "paymentWebView";

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
      AppRoutes.profileDetailView: (context) => const CompleteProfileView(),
      AppRoutes.baseNavigationView: (context) => const BaseNavigationView(),
      AppRoutes.profileView: (context) => const ProfileView(),
      AppRoutes.wishListView: (context) => const WishListView(),
      AppRoutes.profileUpdationView: (context) {
        ProfileUpdationModel profileUpdationModel =
            routeSettings.arguments as ProfileUpdationModel;
        return ProfileUpdationView(
          profileUpdationModel: profileUpdationModel,
        );
      },
      AppRoutes.invoiceCreationView: (context) => InvoiceCreationView(),
      AppRoutes.paymentWebView: (context) {
        PaymentMethod paymentMethod = routeSettings.arguments as PaymentMethod;
        return PaymentWebView(paymentMethod: paymentMethod);
      }
    };
    WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}
