import 'package:crafty_bay/features/home/models/remark_product_model/remark_product_data.dart';

class RemarkProductModel {
  String? msg;
  List<RemarkProductData>? data;

  RemarkProductModel({this.msg, this.data});

  RemarkProductModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <RemarkProductData>[];
      json['data'].forEach((v) {
        data!.add(RemarkProductData.fromJson(v));
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
