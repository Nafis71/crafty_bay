import 'package:crafty_bay/features/category/view_model/category_view_model.dart';
import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:crafty_bay/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:get/get.dart';

class PrefetchService {
  static Future<void> prefetchProductSliderList() async {
    await Get.find<HomeViewModel>().getProductSliderList();
  }

  static Future<void> prefetchCategoryList() async {
    await Get.find<CategoryViewModel>().getCategoryList();
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

  static Future<void> prefetchProductWishList(String token) async{
    await Get.find<WishListViewModel>().getWishList(token);
  }
}
