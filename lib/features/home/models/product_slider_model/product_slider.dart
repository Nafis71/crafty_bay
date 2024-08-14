import 'package:crafty_bay/features/home/models/product_slider_model/product_data.dart';

class ProductSlider {
  String? msg;
  List<ProductSliderData>? data;

  ProductSlider({this.msg, this.data});

  ProductSlider.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <ProductSliderData>[];
      json['data'].forEach((v) {
        data!.add(ProductSliderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
