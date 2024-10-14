import 'package:crafty_bay/features/product_review/models/product_review_model/profile.dart';

class ProductReviewModel {
  int? id;
  String? description;
  int? productId;
  String? createdAt;
  String? updatedAt;
  Profile? profile;
  double? rating;

  ProductReviewModel({
    this.id,
    this.description,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.profile,
    this.rating,
  });

  ProductReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    rating = double.tryParse(json['rating'].toString()) ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}
