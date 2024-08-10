import 'package:crafty_bay/features/authentication/services/auth_service.dart';
import 'package:crafty_bay/services/response/success.dart';
import 'package:crafty_bay/view_models/profile_view_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends GetxController {
  bool _isBusy = false;
  bool _responseStatus = false;
  bool _hasUserData = false;
  Object? response;

  bool get isBusy => _isBusy;

  bool get hasUserData => _hasUserData;

  set setIsBusy(bool value) {
    _isBusy = value;
    update();
  }

  Future<bool> sendOTP(String emailAddress, {bool isResending = false}) async {
    _responseStatus = false;
    if (!isResending) setIsBusy = true;
    response = await AuthService().sendOTP(emailAddress);
    if (response is Success) {
      _responseStatus = true;
    }
    if (!isResending) setIsBusy = false;
    return _responseStatus;
  }

  Future<bool> verifyOTP(String emailAddress, String otp) async {
    _responseStatus = false;
    setIsBusy = true;
    response = await AuthService().verifyOTP(emailAddress, otp);
    if (response is Success) {
      Map<String, dynamic> jsonData =
          (response as Success).response as Map<String, dynamic>;
      String token = jsonData['data'];
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("token", token);
      bool status = await Get.find<ProfileViewModel>().readProfile(response!, token);
      _hasUserData = status;
      localStorage.setBool("hasUserData", status);
      _responseStatus = true;
    }
    setIsBusy = false;
    return _responseStatus;
  }


}
