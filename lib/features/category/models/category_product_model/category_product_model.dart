import 'package:crafty_bay/features/category/models/category_product_model/category_product_data.dart';

class CategoryProductModel {
  String? msg;
  List<CategoryProductData>? categoryProductData;

  CategoryProductModel({this.msg, this.categoryProductData});

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      categoryProductData = <CategoryProductData>[];
      json['data'].forEach((v) {
        categoryProductData!.add(CategoryProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (categoryProductData != null) {
      data['data'] = categoryProductData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
