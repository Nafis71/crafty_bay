import 'package:crafty_bay/features/category/view_model/category_view_model.dart';
import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:crafty_bay/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:get/get.dart';

import '../view_model/profile_view_model.dart';

class PrefetchService {
  static Future<bool> prefetchProductSliderList() async {
    return await Get.find<HomeViewModel>().getProductSliderList();
  }

  static Future<bool> prefetchCategoryList() async {
    return await Get.find<CategoryViewModel>().getCategoryList();
  }

  static Future<bool> prefetchPopularProductData() async {
    return await Get.find<HomeViewModel>().getPopularProduct();
  }

  static Future<bool> prefetchSpecialProductData() async {
    return await Get.find<HomeViewModel>().getSpecialProduct();
  }

  static Future<bool> prefetchNewProductData() async {
    return await Get.find<HomeViewModel>().getNewProduct();
  }

  static Future<void> prefetchProductWishList(String token) async{
    await Get.find<WishListViewModel>().getWishList(token);
  }

  static Future<List<bool>> prefetchData() async{
    return await Future.wait([
      prefetchProductSliderList(),
      prefetchCategoryList(),
      prefetchPopularProductData(),
      prefetchSpecialProductData(),
      prefetchNewProductData(),
    ]);
  }
}
