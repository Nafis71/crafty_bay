import 'package:crafty_bay/features/home/models/category_list_model/category_data.dart';
import 'package:crafty_bay/features/home/models/product_slider_model/product_slider.dart';
import 'package:crafty_bay/features/home/models/remark_product_model/remark_product_data.dart';
import 'package:crafty_bay/features/home/models/remark_product_model/remark_product_model.dart';
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
  List<RemarkProductData> _popularProductList = [];
  List<RemarkProductData> _specialProductList = [];
  List<RemarkProductData> _newProductList = [];

  int get carouselIndex => _carouselIndex;

  List<ProductSliderData> get productSliderList => _productSliderList;

  List<CategoryData> get categoryList => _categoryList;

  List<RemarkProductData> get popularProductList => _popularProductList;

  List<RemarkProductData> get specialProductList => _specialProductList;

  List<RemarkProductData> get newProductList => _newProductList;

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
      for (CategoryData categoryData in categoryModel.data!) {
        _categoryList.add(categoryData);
      }
    }
  }

  Future<void> getPopularProduct() async {
    RemarkProductModel? remarkProductModel =
        await getProductByRemark("popular");
    if (remarkProductModel != null) {
      _popularProductList = await getProductList(remarkProductModel);
    }
  }

  Future<void> getSpecialProduct() async {
    RemarkProductModel? remarkProductModel =
        await getProductByRemark("special");
    if (remarkProductModel != null) {
      _specialProductList = await getProductList(remarkProductModel);
    }
  }

  Future<void> getNewProduct() async {
    RemarkProductModel? remarkProductModel = await getProductByRemark("new");
    if (remarkProductModel != null) {
      _newProductList = await getProductList(remarkProductModel);
    }
  }

  Future<List<RemarkProductData>> getProductList(
      RemarkProductModel remarkProductModel) async {
    List<RemarkProductData> productData = [];
    for (RemarkProductData popularProductData in remarkProductModel.data!) {
      productData.add(popularProductData);
    }
    return productData;
  }

  Future<RemarkProductModel?> getProductByRemark(String remark) async {
    response = await HomeProductService().getProductByRemark(remark);
    if (response is Success) {
      RemarkProductModel remarkProductModel = RemarkProductModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      return remarkProductModel;
    }
    return null;
  }
}
