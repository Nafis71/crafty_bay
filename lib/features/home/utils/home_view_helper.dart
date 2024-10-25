import 'package:crafty_bay/features/home/state_holders/home_view_state.dart';
import 'package:get/get.dart';

import '../../../core/services/prefetch_service/prefetch_service.dart';

class HomeViewHelper {
  static Future<void> fetchHomeData() async {
    List<bool> responses = await PrefetchService.fetchHomeData();
    if (responses.contains(false)) {
      fetchHomeData();
    } else {
      Get.find<HomeViewState>().update();
    }
  }
}
