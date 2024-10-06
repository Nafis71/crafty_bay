import 'package:crafty_bay/features/wish_list/models/WishListProductData.dart';

class WishListData {
  int? id;
  int? productId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  WishListProductData? wishListProductData;

  WishListData(
      {this.id,
      this.productId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.wishListProductData});

  WishListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    wishListProductData = json['product'] != null
        ? new WishListProductData.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.wishListProductData != null) {
      data['product'] = this.wishListProductData!.toJson();
    }
    return data;
  }
}
