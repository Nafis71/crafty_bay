import 'package:crafty_bay/common/services/response/success.dart';
import 'package:crafty_bay/features/product_details/models/product.dart';
import 'package:crafty_bay/features/product_details/models/product_details_model.dart';
import 'package:crafty_bay/features/product_details/services/product_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductViewModel extends GetxController {
  Object? response;
  Product? _productData;
  final List<String> _carouselImageList = [];
  List<String> _productSizeList = [];
  bool _isBusy = false;
  bool _responseStatus = false;

  bool get isBusy => _isBusy;

  Product? get productData => _productData;

  List<String> get carouselImageList => _carouselImageList;

  List<String> get productSizeList => _productSizeList;

  set setIsBusy(bool value) {
    _isBusy = value;
    update();
  }

  Future<bool> getProductDetails(int productId) async {
    _responseStatus = false;
    setIsBusy = true;
    response = await ProductService().getProductDetails(productId.toString());
    if (response is Success) {
      try {
        ProductDetailsModel productDetailsModel = ProductDetailsModel.fromJson(
            (response as Success).response as Map<String, dynamic>);
        if (productDetailsModel.data!.isNotEmpty) {
          loadCarouselImageList(productDetailsModel);
          _productSizeList =
              getProductSizes(productDetailsModel.data![0].size.toString());
          _productData = productDetailsModel.data![0].product;
          _responseStatus = true;
        }
      } catch (exception) {
        if (kDebugMode) {
          debugPrint(exception.toString());
        }
      }
    }
    setIsBusy = false;
    return _responseStatus;
  }

  void loadCarouselImageList(ProductDetailsModel productDetailsModel) {
    _carouselImageList.add(productDetailsModel.data![0].img1!);
    _carouselImageList.add(productDetailsModel.data![0].img2!);
    _carouselImageList.add(productDetailsModel.data![0].img3!);
    _carouselImageList.add(productDetailsModel.data![0].img4!);
  }

  List<String> getProductSizes(String size) {
    return size.split(",");
  }

  void resetViewModel() {
    _carouselImageList.clear();
    _productSizeList.clear();
    _productData = null;
  }
}
