import 'package:crafty_bay/core/services/response/success.dart';
import 'package:crafty_bay/features/product_review/models/product_review_model/product_review_model.dart';
import 'package:crafty_bay/features/product_review/services/product_review_service.dart';
import 'package:get/get.dart';

class ProductReviewState extends GetxController {
  bool _isBusy = false;
  bool _isCreatingReview = false;
  bool _responseStatus = false;
  List<ProductReviewModel> _productReviewList = [];
  Object? response;
  int _productRating = 3;

  bool get isBusy => _isBusy;

  bool get isCreatingReview => _isCreatingReview;

  set setProductRating(int productRating) {
    _productRating = productRating;
  }

  List<ProductReviewModel> get productReviewList => _productReviewList;

  Future<bool> getProductReview(String productId) async {
    _productReviewList.clear();
    _responseStatus = false;
    _isBusy = true;
    response = await ProductReviewService().getProductReview(productId);
    if (response is Success) {
      Map<String, dynamic> jsonData =
          (response as Success).response as Map<String, dynamic>;
      List<dynamic> jsonList = jsonData['data'];
      for (Map<String, dynamic> json in jsonList) {
        _productReviewList.add(ProductReviewModel.fromJson(json));
        _productReviewList = _productReviewList.reversed.toList();
      }
      _responseStatus = true;
    }
    _isBusy = false;
    update();
    return _responseStatus;
  }

  Future<bool> createProductReview({
    required int productId,
    required String token,
    required String review,
  }) async {
    _responseStatus = false;
    _isCreatingReview = true;
    update();
    Map<String, dynamic> reviewJson = {
      "description": review,
      "product_id": productId,
      "rating": _productRating
    };
    response = await ProductReviewService().createReview(
      token,
      reviewJson,
    );
    if (response is Success) {
      await getProductReview(productId.toString());
      _responseStatus = true;
    }
    _isCreatingReview = false;
    update();
    return _responseStatus;
  }
}
