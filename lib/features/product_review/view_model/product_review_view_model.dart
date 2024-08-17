import 'package:crafty_bay/common/services/response/success.dart';
import 'package:crafty_bay/features/product_review/models/product_review_model/product_review_model.dart';
import 'package:crafty_bay/features/product_review/services/product_review_service.dart';
import 'package:get/get.dart';

class ProductReviewViewModel extends GetxController{
  bool _isBusy = false;
  bool _responseStatus = false;
  List<ProductReviewModel> _productReviewList = [];
  Object? response;

  bool get isBusy => _isBusy;

  List<ProductReviewModel> get productReviewList => _productReviewList;

  Future<bool> getProductReview(String productId) async{
    _productReviewList.clear();
    _responseStatus = false;
    _isBusy = true;
    response = await ProductReviewService().getProductReview(productId);
    if(response is Success){
      Map<String,dynamic> jsonData = (response as Success).response as Map<String,dynamic>;
      List<dynamic> jsonList = jsonData['data'];
      for(Map<String,dynamic> json in jsonList){
        _productReviewList.add(ProductReviewModel.fromJson(json));
      }
      _responseStatus = true;
    }
    _isBusy = false;
    update();
    return _responseStatus;
  }

}