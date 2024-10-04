import 'package:crafty_bay/utils/app_routes.dart';
import 'package:get/get.dart';

import '../../view_model/profile_view_model.dart';

class UserAuthService {
  static Future<bool> isUserAuthenticated(
      {required Function(dynamic) futureExecution}) async {
    bool isTokenExpired = await Get.find<ProfileViewModel>().isTokenExpired();
    if (isTokenExpired) {
      navigator!.pushNamed(AppRoutes.loginView, arguments: futureExecution);
      return false;
    }
    return true;
  }
}
