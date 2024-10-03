import 'package:crafty_bay/features/category/view_model/category_view_model.dart';
import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:crafty_bay/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:get/get.dart';

class PrefetchService {
  static Future<bool> prefetchProductSliderList() async {
    if (Get.find<HomeViewModel>().productSliderList.isNotEmpty) {
      return true;
    }
    return await Get.find<HomeViewModel>().getProductSliderList();
  }

  static Future<bool> prefetchCategoryList() async {
    if (Get.find<CategoryViewModel>().categoryList.isNotEmpty) {
      return true;
    }
    return await Get.find<CategoryViewModel>().getCategoryList();
  }

  static Future<bool> prefetchPopularProductData() async {
    if (Get.find<HomeViewModel>().popularProductList.isNotEmpty) {
      return true;
    }
    return await Get.find<HomeViewModel>().getPopularProduct();
  }

  static Future<bool> prefetchSpecialProductData() async {
    if (Get.find<HomeViewModel>().specialProductList.isNotEmpty) {
      return true;
    }
    return await Get.find<HomeViewModel>().getSpecialProduct();
  }

  static Future<bool> prefetchNewProductData() async {
    if (Get.find<HomeViewModel>().newProductList.isNotEmpty) {
      return true;
    }
    return await Get.find<HomeViewModel>().getNewProduct();
  }

  static Future<void> prefetchProductWishList(String token) async {
    await Get.find<WishListViewModel>().getWishList(token);
  }

  static Future<List<bool>> prefetchData() async {
    return await Future.wait([
      prefetchProductSliderList(),
      prefetchCategoryList(),
      prefetchPopularProductData(),
      prefetchSpecialProductData(),
      prefetchNewProductData(),
    ]);
  }
}
