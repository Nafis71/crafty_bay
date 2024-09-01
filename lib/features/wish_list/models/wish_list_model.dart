class WishListModel {
  int? id;
  String? email;
  int? productId;
  String? createdAt;
  String? updatedAt;

  WishListModel({
    this.id,
    this.email,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  WishListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
