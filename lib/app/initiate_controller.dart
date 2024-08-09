import 'package:crafty_bay/features/authentication_screens/otp_verification_screen/countdown_timer.dart';
import 'package:crafty_bay/features/authentication_screens/view_model/auth_view_model.dart';
import 'package:get/get.dart';

class InitiateController extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>CountdownTimer());
    Get.lazyPut(()=>AuthViewModel());
  }

}