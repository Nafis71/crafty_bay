import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:get/get.dart';

class PrefetchService {
  static Future<void> prefetchProductSliderList() async {
    await Get.find<HomeViewModel>().getProductSliderList();
  }

  static Future<void> prefetchCategoryList() async {
    await Get.find<HomeViewModel>().getCategoryList();
  }

  static Future<void> prefetchPopularProductData() async {
    await Get.find<HomeViewModel>().getPopularProduct();
  }

  static Future<void> prefetchSpecialProductData() async {
    await Get.find<HomeViewModel>().getSpecialProduct();
  }

  static Future<void> prefetchNewProductData() async {
    await Get.find<HomeViewModel>().getNewProduct();
  }
}
