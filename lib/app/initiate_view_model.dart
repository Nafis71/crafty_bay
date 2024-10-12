import 'package:crafty_bay/core/view_model/profile_view_model.dart';
import 'package:crafty_bay/features/authentication/view_model/auth_view_model.dart';
import 'package:crafty_bay/features/home/state_holders/offer_carousel_state.dart';
import 'package:crafty_bay/features/product_review/view_model/product_review_view_model.dart';
import 'package:crafty_bay/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:get/get.dart';
import '../features/authentication/views/otp_verification_view/state_holders/countdown_timer.dart';
import '../features/base_navigation/state_holders/base_navigation_state.dart';
import '../features/cart/state_holders/cart_view_state.dart';
import '../features/category/state_holders/category_view_state.dart';
import '../features/home/state_holders/home_state.dart';
import '../features/product_details/state_holders/product_state.dart';

class InitiateViewModel extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountdownTimerState());
    Get.lazyPut(() => BaseNavigationState());
    Get.lazyPut(() => CategoryViewState());
    Get.lazyPut(() => ProductReviewViewModel());
    Get.put(ProductState());
    Get.lazyPut(()=>CartViewState(Get.find<ProductState>()));
    Get.put(HomeState());
    Get.put(OfferCarouselState());
    Get.put(WishListViewModel());
    Get.put(AuthViewModel());
    Get.put(ProfileViewModel());
  }
}
