import 'package:crafty_bay/features/authentication/view_model/auth_view_model.dart';
import 'package:crafty_bay/view_models/profile_view_model.dart';
import 'package:get/get.dart';

import '../features/authentication/views/otp_verification_view/countdown_timer.dart';

class InitiateController extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>CountdownTimer());
    Get.lazyPut(()=>AuthViewModel());
    Get.lazyPut(()=>ProfileViewModel());
  }

}