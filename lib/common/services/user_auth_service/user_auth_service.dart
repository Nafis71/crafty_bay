import 'package:crafty_bay/utils/app_routes.dart';
import 'package:get/get.dart';

import '../../view_model/profile_view_model.dart';

class UserAuthService {
  static Future<bool> isUserAuthenticated() async {
    bool isTokenExpired = await Get.find<ProfileViewModel>().validateToken();
    if (isTokenExpired) {
      navigator!.pushNamed(AppRoutes.loginView);
      return false;
    }
    return true;
  }
}
