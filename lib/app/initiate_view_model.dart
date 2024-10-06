import 'package:crafty_bay/core/view_model/profile_view_model.dart';
import 'package:crafty_bay/features/authentication/view_model/auth_view_model.dart';
import 'package:crafty_bay/features/base_navigation/view_model/base_navigation_view_model.dart';
import 'package:crafty_bay/features/cart/view_model/cart_view_model.dart';
import 'package:crafty_bay/features/category/view_model/category_view_model.dart';
import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:crafty_bay/features/product_review/view_model/product_review_view_model.dart';
import 'package:crafty_bay/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:get/get.dart';

import '../features/authentication/views/otp_verification_view/countdown_timer.dart';

class InitiateViewModel extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountdownTimer());
    Get.lazyPut(() => BaseNavigationViewModel());
    Get.lazyPut(() => CategoryViewModel());
    Get.lazyPut(() => ProductViewModel());
    Get.lazyPut(() => ProductReviewViewModel());
    Get.lazyPut(() => ProductViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.put(HomeViewModel());
    Get.put(WishListViewModel());
    Get.put(AuthViewModel());
    Get.put(ProfileViewModel());
  }
}
