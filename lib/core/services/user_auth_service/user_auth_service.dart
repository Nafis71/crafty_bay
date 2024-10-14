import 'package:crafty_bay/core/utils/app_routes.dart';
import 'package:get/get.dart';

import '../../state_holders/profile_state.dart';

class UserAuthService {
  static Future<bool> isUserAuthenticated(
      {required Function(dynamic) futureExecution}) async {
    bool isTokenExpired = await Get.find<ProfileState>().isTokenExpired();
    if (isTokenExpired) {
      navigator!.pushNamed(AppRoutes.loginView, arguments: futureExecution);
      return false;
    }
    if (Get.find<ProfileState>().userModel == null) {
      navigator!.pushNamed(AppRoutes.profileDetailView);
      return false;
    }
    return true;
  }
}
