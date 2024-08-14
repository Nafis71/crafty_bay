import 'package:crafty_bay/features/home/models/category_list_model/category_data.dart';
import 'package:crafty_bay/features/home/models/product_slider_model/product_slider.dart';
import 'package:crafty_bay/features/home/services/home_product_service.dart';
import 'package:crafty_bay/services/response/success.dart';
import 'package:get/get.dart';

import '../models/category_list_model/category_list_model.dart';
import '../models/product_slider_model/product_data.dart';

class HomeViewModel extends GetxController {
  int _carouselIndex = 0;
  Object? response;
  final List<ProductSliderData> _productSliderList = [];
  final List<CategoryData> _categoryList = [];

  int get carouselIndex => _carouselIndex;

  List<ProductSliderData> get productSliderList => _productSliderList;
  List<CategoryData> get categoryList => _categoryList;

  set setCarouselIndex(int index) {
    _carouselIndex = index;
    update();
  }

  Future<void> getProductSliderList() async {
    response = await HomeProductService().getProductSliderList();
    if (response is Success) {
      ProductSlider productSliderModel = ProductSlider.fromJson(
          (response as Success).response as Map<String, dynamic>);
      for (ProductSliderData productSliderData in productSliderModel.data!) {
        _productSliderList.add(productSliderData);
      }
    }
  }

  Future<void> getCategoryList() async {
    response = await HomeProductService().getCategoryList();
    if (response is Success) {
      CategoryModel categoryModel = CategoryModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      for(CategoryData categoryData  in categoryModel.data!){
        _categoryList.add(categoryData);
      }
    }
  }

}
