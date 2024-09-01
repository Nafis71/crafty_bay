import 'package:crafty_bay/features/cart/models/cart_list_model/cart_data.dart';

class CartListModel {
  String? msg;
  List<CartData>? cartData;

  CartListModel({this.msg, this.cartData});

  CartListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      cartData = <CartData>[];
      json['data'].forEach((v) {
        cartData!.add(CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (cartData != null) {
      data['data'] = cartData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
