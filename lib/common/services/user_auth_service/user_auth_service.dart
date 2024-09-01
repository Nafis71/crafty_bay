import 'package:crafty_bay/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../view_model/profile_view_model.dart';

class UserAuthService {
  static Future<bool> _isUserAuthenticated(BuildContext context) async {
    bool isTokenExpired = await Get.find<ProfileViewModel>().validateToken();
    if (isTokenExpired) {
      Navigator.pushNamed(context, AppRoutes.loginView);
      return false;
    }

    bool isUserDataAvailable =
        await Get.find<ProfileViewModel>().checkUserData();
    if (!isUserDataAvailable && context.mounted) {
      Navigator.pushNamed(context, AppRoutes.profileDetailView);
      return false;
    }
    await Get.find<ProfileViewModel>().loadUserDataFromStorage();
    return true;
  }
}
