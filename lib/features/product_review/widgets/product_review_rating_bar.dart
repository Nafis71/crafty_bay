import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../state_holders/product_review_state.dart';

class ProductReviewRatingBar {
  static RatingBar show({required double initialRating, bool onlyReadable = false}) {
    return RatingBar.builder(
      initialRating: initialRating,
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
      ignoreGestures: onlyReadable,
      onRatingUpdate: (rating) {
        Get.find<ProductReviewState>().setProductRating = rating.ceil();
      },
    );
  }
}
