import 'package:crafty_bay/features/category/services/category_service.dart';
import 'package:get/get.dart';

import '../../../services/response/success.dart';
import '../models/category_data.dart';
import '../models/category_list_model.dart';

class CategoryViewModel extends GetxController{
  final List<CategoryData> _categoryList = [];
  Object? response;
  List<CategoryData> get categoryList => _categoryList;

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
}