import 'dart:convert';
import 'package:crafty_bay/features/authentication/services/profile_detail_service.dart';
import 'package:crafty_bay/models/user_model/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/response/success.dart';

class ProfileViewModel extends GetxController{
  late UserModel _userModel;
  Object? response;
  bool _responseStatus = false;
  bool _isBusy = false;

  bool get isBusy => _isBusy;

  set setIsBusy(bool value){
    _isBusy = value;
    update();
  }

  UserModel get userModel => _userModel;


  Future<bool> readProfile(Object response, String token) async {
    response = await ProfileDetailService().readProfile(token);
    if (response is Success) {
      Map<String, dynamic> jsonData =
      (response).response as Map<String, dynamic>;
      List<Map<String,dynamic>> userData = jsonData['data'];
      if (userData.isNotEmpty) {
        UserModel userModel = UserModel.fromJson(userData[0]);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        await saveUserData(userModel, localStorage);
        return true;
      }
    }
    return false;
  }

  Future<bool> createProfile({
    required String firstName,
    required String lastName,
    required String mobile,
    required String city,
    required String shippingAddress,
    required String token,
  }) async {
    _responseStatus = false;
    setIsBusy = true;
    Map<String, String> json = {
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "city": city,
      "shippingAddress": shippingAddress
    };
    response = await ProfileDetailService().createProfile(token, json);
    if(response is Success){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setBool("hasUserData", true);
      Map<String,dynamic> jsonData = (response as Success).response as Map<String,dynamic>;
      UserModel userModel = UserModel.fromJson(jsonData['data'][0]);
      await saveUserData(userModel, localStorage);
      _responseStatus = true;
    }
    setIsBusy = false;
    return _responseStatus;
  }

  Future<void> saveUserData(UserModel userModel, SharedPreferences localStorage) async{
    localStorage.setString("userData", jsonEncode(userModel.toJson()));
    _userModel = userModel;
  }
}