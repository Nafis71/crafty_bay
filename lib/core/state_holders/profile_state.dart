import 'dart:convert';

import 'package:crafty_bay/core/models/user_model/user_model.dart';
import 'package:crafty_bay/core/services/profile_detail_service.dart';
import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/response/success.dart';

class ProfileState extends GetxController {
  UserModel? _userModel;
  Object? response;
  bool _responseStatus = false;
  bool _isBusy = false;
  String _token = "";

  bool get isBusy => _isBusy;

  String get token => _token;

  set setIsBusy(bool value) {
    _isBusy = value;
    update();
  }

  set setToken(String token) {
    _token = token;
  }

  UserModel? get userModel => _userModel;

  set setUserData(UserModel userModel) {
    _userModel = userModel;
  }

  Future<bool> isTokenExpired() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString("token");
    if (token == null || JwtDecoder.isExpired(token)) {
      localStorage.clear();
      return true;
    }
    _token = token;
    return false;
  }

  Future<bool> checkUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool? hasUserData = localStorage.getBool("hasUserData");
    if (hasUserData == null || !hasUserData) {
      return false;
    }
    return true;
  }

  Future<void> loadUserDataFromStorage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? userData = localStorage.getString("userData");
    if (userData != null && userData.isNotEmpty) {
      _userModel = UserModel.fromJson(
        jsonDecode(
          userData,
        ),
      );
    }
  }

  Future<bool> readProfile(Object response, String token) async {
    response = await ProfileDetailService().readProfile(token);
    if (response is Success) {
      Map<String, dynamic> jsonData =
          (response).response as Map<String, dynamic>;
      Map<String, dynamic>? userData = jsonData['data'];
      if (userData != null) {
        UserModel userModel = UserModel.fromJson(userData);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        await saveUserData(userModel, localStorage);
        return true;
      }
    }
    return false;
  }

  Future<bool> createProfile(
      {required String firstName,
      required String lastName,
      required String mobile,
      required String city,
      required String shippingAddress,
      required String postCode}) async {
    _responseStatus = false;
    setIsBusy = true;
    Map<String, String> json = {
      "cus_name": "${firstName} ${lastName}",
      "cus_add": shippingAddress,
      "cus_city": city,
      "cus_state": city,
      "cus_postcode": "1207",
      "cus_country": "Bangladesh",
      "cus_phone": mobile,
      "cus_fax": mobile,
      "ship_name": firstName + lastName,
      "ship_add": shippingAddress,
      "ship_city": city,
      "ship_state": city,
      "ship_postcode": postCode,
      "ship_country": "Bangladesh",
      "ship_phone": mobile
    };
    response = await ProfileDetailService().createProfile(_token, json);
    if (response is Success) {
      bool readStatus = await readProfile(response!, token);
      if (readStatus) {
        _responseStatus = true;
      }
    }
    setIsBusy = false;
    return _responseStatus;
  }

  Future<bool> updateProfile(String profileUpdationType, String value) async {
    setIsBusy = true;
    _responseStatus = false;
    switch (profileUpdationType) {
      case AppStrings.changeNameText:
        userModel!.cusName = value;
      case AppStrings.changeShipAddressText:
        userModel!.shipAdd = value;
      case AppStrings.changeContactNumberText:
        userModel!.cusPhone = value;
    }
    response =
        await ProfileDetailService().createProfile(token, userModel!.toJson());
    if (response is Success) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      saveUserData(userModel!, localStorage);
      _responseStatus = true;
    }
    setIsBusy = false;
    update();
    return _responseStatus;
  }

  Future<void> saveUserData(
      UserModel userModel, SharedPreferences localStorage) async {
    localStorage.setString(
        "userData", jsonEncode(userModel.toJsonFromStorage()));
    localStorage.setBool("hasUserData", true);
    _userModel = userModel;
  }

  Future<void> logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    _userModel = null;
    _token = "";
  }
}
