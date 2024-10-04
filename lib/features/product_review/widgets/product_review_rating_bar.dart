import 'package:crafty_bay/features/product_review/view_model/product_review_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProductReviewRatingBar {
  static RatingBar show() {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      glow: false,
      unratedColor: Colors.grey.shade200,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        Get.find<ProductReviewViewModel>().setProductRating = rating.ceil();
      },
    );
  }
}
