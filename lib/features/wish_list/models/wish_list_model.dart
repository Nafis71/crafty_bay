import 'package:crafty_bay/features/wish_list/models/WishListData.dart';

class WishListModel {
  String? msg;
  List<WishListData>? wishListData;

  WishListModel({this.msg, this.wishListData});

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      wishListData = <WishListData>[];
      json['data'].forEach((v) {
        wishListData!.add(new WishListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.wishListData != null) {
      data['data'] = this.wishListData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
