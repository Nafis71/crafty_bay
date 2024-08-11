import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:get/get.dart';

class PrefetchService{
  static Future<void> prefetchProductSliderList() async{
    await Get.find<HomeViewModel>().getProductSliderList();
  }
}