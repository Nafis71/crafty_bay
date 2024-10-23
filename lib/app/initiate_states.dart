import 'package:crafty_bay/features/complete_profile/state_holders/complete_profile_view_state.dart';
import 'package:crafty_bay/features/home/state_holders/offer_carousel_state.dart';
import 'package:crafty_bay/features/onboarding/splash_view/state_holders/splash_view_state.dart';
import 'package:crafty_bay/features/payment/invoice_creation/state_holders/invoice_creation_state.dart';
import 'package:crafty_bay/features/payment/payment_webView/state_holders/payment_webView_state.dart';
import 'package:get/get.dart';
import 'package:crafty_bay/features/authentication/shared/state_holders/auth_state.dart';
import 'package:crafty_bay/features/profile/shared/state_holders/profile_state.dart';
import 'package:crafty_bay/features/authentication/otp_verification_view/state_holders/countdown_timer.dart';
import 'package:crafty_bay/features/base_navigation/state_holders/base_navigation_state.dart';
import 'package:crafty_bay/features/cart/state_holders/cart_view_state.dart';
import 'package:crafty_bay/features/category/state_holders/category_view_state.dart';
import 'package:crafty_bay/features/home/state_holders/home_state.dart';
import 'package:crafty_bay/features/product_details/state_holders/product_state.dart';
import 'package:crafty_bay/features/product_review/shared/state_holders/product_review_state.dart';
import 'package:crafty_bay/features/wish_list/state_holders/wish_list_state.dart';

class InitiateViewModel extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashViewState());
    Get.lazyPut(() => CountdownTimerState());
    Get.lazyPut(() => BaseNavigationState());
    Get.lazyPut(() => CategoryViewState());
    Get.lazyPut(() => ProductReviewState());
    Get.put(ProductState());
    Get.lazyPut(() => CartViewState(Get.find<ProductState>()));
    Get.put(HomeState());
    Get.put(OfferCarouselState());
    Get.put(WishListState());
    Get.put(ProfileState());
    Get.put(CompleteProfileViewState());
    Get.put(AuthState(Get.find<ProfileState>()));
    Get.put(InvoiceCreationState());
    Get.put(PaymentWebViewState(Get.find<CartViewState>()));
  }
}
