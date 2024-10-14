import 'package:get/get.dart';

import '../../features/category/state_holders/category_view_state.dart';
import '../../features/home/state_holders/home_state.dart';
import '../../features/wish_list/state_holders/wish_list_state.dart';

class PrefetchService {
  static Future<bool> prefetchProductSliderList() async {
    if (Get.find<HomeState>().productSliderList.isNotEmpty) {
      return true;
    }
    return await Get.find<HomeState>().getProductSliderList();
  }

  static Future<bool> prefetchCategoryList() async {
    if (Get.find<CategoryViewState>().categoryList.isNotEmpty) {
      return true;
    }
    return await Get.find<CategoryViewState>().getCategoryList();
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
    await Get.find<WishListState>().getWishList(token);
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
