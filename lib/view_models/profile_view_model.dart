import 'dart:convert';
import 'package:crafty_bay/features/authentication/services/profile_detail_service.dart';
import 'package:crafty_bay/models/user_model/user_model.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/response/success.dart';
import '../utils/app_routes.dart';

class ProfileViewModel extends GetxController{
  late UserModel _userModel;
  Object? response;
  bool _responseStatus = false;
  bool _isBusy = false;
  String _token = "";

  bool get isBusy => _isBusy;
  String get token=> _token;

  set setIsBusy(bool value){
    _isBusy = value;
    update();
  }

  set setToken(String token){
    _token = token;
  }

  UserModel get userModel => _userModel;

  set setUserData(UserModel userModel){
    _userModel = userModel;
  }

  Future<bool> validateToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString("token");
    if (token == null || JwtDecoder.isExpired(token)) {
      return true;
    }
    _token = token;
    return false;
  }

  Future<bool> checkUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool? hasUserData = localStorage.getBool("hasUserData");
    if (hasUserData == null || !hasUserData) {
      return false;
    }
    return true;
  }

  Future<void> loadUserDataFromStorage() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    _userModel = UserModel.fromJson(
      jsonDecode(
        localStorage.getString("userData").toString(),
      ),
    );
  }

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
    response = await ProfileDetailService().createProfile(_token, json);
    if(response is Success){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setBool("hasUserData", true);
      Map<String,dynamic> jsonData = (response as Success).response as Map<String,dynamic>;
      UserModel userModel = UserModel.fromJson(jsonData['data']);
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