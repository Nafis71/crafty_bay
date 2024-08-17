import 'package:crafty_bay/features/category/models/category_product_model/category_product_data.dart';
import 'package:crafty_bay/features/category/models/category_product_model/category_product_model.dart';
import 'package:crafty_bay/features/category/services/category_service.dart';
import 'package:get/get.dart';

import '../../../common/services/response/success.dart';
import '../models/category_model/category_data.dart';
import '../models/category_model/category_list_model.dart';

class CategoryViewModel extends GetxController {
  final List<CategoryData> _categoryList = [];
  final List<CategoryProductData> _categoryProductData = [];
  Object? response;
  bool _isBusy = false;
  bool _responseStatus = false;

  List<CategoryData> get categoryList => _categoryList;

  List<CategoryProductData> get categoryProductData => _categoryProductData;

  bool get isBusy => _isBusy;

  set setIsBusy(bool value) {
    _isBusy = value;
  }

  Future<void> getCategoryList() async {
    response = await CategoryService().getCategoryList();
    if (response is Success) {
      CategoryModel categoryModel = CategoryModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      for (CategoryData categoryData in categoryModel.data!) {
        _categoryList.add(categoryData);
      }
    }
  }

  Future<bool> getProductByCategory(String categoryId) async {
    _categoryProductData.clear();
    _responseStatus = false;
    setIsBusy = true;
    response = await CategoryService().getProductByCategory(categoryId);
    if (response is Success) {
      CategoryProductModel categoryProductModel = CategoryProductModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      for (CategoryProductData categoryProductData
          in categoryProductModel.categoryProductData!) {
        _categoryProductData.add(categoryProductData);
      }
      _responseStatus = true;
    }
    setIsBusy = false;
    update();
    return _responseStatus;
  }
}