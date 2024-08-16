import 'package:crafty_bay/common/view_models/profile_view_model.dart';
import 'package:crafty_bay/features/authentication/view_model/auth_view_model.dart';
import 'package:crafty_bay/features/base_navigation/view_model/base_navigation_view_model.dart';
    import 'package:crafty_bay/features/category/view_model/category_view_model.dart';
    import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
    import 'package:get/get.dart';
    import '../features/authentication/views/otp_verification_view/countdown_timer.dart';

    class InitiateViewModel extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut(() => CountdownTimer());
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => ProfileViewModel());
    Get.lazyPut(() => BaseNavigationViewModel());
    Get.lazyPut(() => CategoryViewModel());
    Get.lazyPut(() => ProductViewModel());
    Get.put(HomeViewModel());
  }
}
