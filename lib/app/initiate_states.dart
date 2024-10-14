import 'package:crafty_bay/features/authentication/state_holders/auth_state.dart';
import 'package:crafty_bay/features/home/state_holders/offer_carousel_state.dart';
import 'package:get/get.dart';

import '../core/state_holders/profile_state.dart';
import '../features/authentication/views/otp_verification_view/state_holders/countdown_timer.dart';
import '../features/base_navigation/state_holders/base_navigation_state.dart';
import '../features/cart/state_holders/cart_view_state.dart';
import '../features/category/state_holders/category_view_state.dart';
import '../features/home/state_holders/home_state.dart';
import '../features/product_details/state_holders/product_state.dart';
import '../features/product_review/state_holders/product_review_state.dart';
import '../features/wish_list/state_holders/wish_list_state.dart';

class InitiateViewModel extends Bindings {
  @override
  void dependencies() {
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
    Get.put(AuthState(Get.find<ProfileState>()));
  }
}
