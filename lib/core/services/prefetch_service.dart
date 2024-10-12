import 'package:crafty_bay/features/category/view_model/category_view_model.dart';
import 'package:crafty_bay/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:get/get.dart';

import '../../features/home/state_holders/home_state.dart';

class PrefetchService {
  static Future<bool> prefetchProductSliderList() async {
    if (Get.find<HomeState>().productSliderList.isNotEmpty) {
      return true;
    }
    return await Get.find<HomeState>().getProductSliderList();
  }

  static Future<bool> prefetchCategoryList() async {
    if (Get.find<CategoryViewModel>().categoryList.isNotEmpty) {
      return true;
    }
    return await Get.find<CategoryViewModel>().getCategoryList();
  }

  static Future<bool> prefetchPopularProductData() async {
    if (Get.find<HomeState>().popularProductList.isNotEmpty) {
      return true;
    }
    return await Get.find<HomeState>().getPopularProduct();
  }

  static Future<bool> prefetchSpecialProductData() async {
    if (Get.find<HomeState>().specialProductList.isNotEmpty) {
      return true;
    }
    return await Get.find<HomeState>().getSpecialProduct();
  }

  static Future<bool> prefetchNewProductData() async {
    if (Get.find<HomeState>().newProductList.isNotEmpty) {
      return true;
    }
    return await Get.find<HomeState>().getNewProduct();
  }

  static Future<void> prefetchProductWishList(String token) async {
    await Get.find<WishListViewModel>().getWishList(token);
  }

  static Future<List<bool>> fetchHomeData() async {
    return await Future.wait([
      prefetchProductSliderList(),
      prefetchCategoryList(),
      prefetchPopularProductData(),
      prefetchSpecialProductData(),
      prefetchNewProductData(),
    ]);
  }
}
