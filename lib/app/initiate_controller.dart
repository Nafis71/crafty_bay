import 'package:crafty_bay/views/authentication_screens/otp_verification_screen/countdown_timer.dart';
import 'package:get/get.dart';

class InitiateController extends Bindings{
  @override
  void dependencies() {
    Get.put(CountdownTimer());
  }

}