import 'package:crafty_bay/services/response/success.dart';
import 'package:crafty_bay/features/authentication_screens/services/auth_service.dart';
import 'package:get/get.dart';


class AuthViewModel extends GetxController{
  bool _isBusy = false;
  bool _responseStatus = false;
  Object? response;

  bool get isBusy => _isBusy;

  set setIsBusy(bool value){
    _isBusy = value;
    update();
  }

  Future<bool> sendOTP(String emailAddress) async{
    _responseStatus = false;
    setIsBusy = true;
    response = await AuthService().sendOTP(emailAddress);
    if(response is Success){
      _responseStatus = true;
    }
    setIsBusy = false;
    return _responseStatus;
  }

}