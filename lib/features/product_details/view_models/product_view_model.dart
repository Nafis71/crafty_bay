import 'package:crafty_bay/common/services/response/success.dart';
import 'package:crafty_bay/features/product_details/models/product.dart';
import 'package:crafty_bay/features/product_details/models/product_details_model.dart';
import 'package:crafty_bay/features/product_details/services/product_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductViewModel extends GetxController {
  Object? response;
  Object? cartResponse;
  Product? _productData;
  final List<String> _carouselImageList = [];
  List<String> _productSizeList = [];
  List<String> _productColorList = [];
  bool _isBusy = false;
  bool _isAddingToCart = false;
  bool _isItemAddedToCart = false;
  bool _responseStatus = false;
  int selectedColor = 0;
  int selectedSize = 0;
  int _productQuantity = 1;

  bool get isBusy => _isBusy;

  bool get isAddingToCart => _isAddingToCart;

  bool get isItemAddedToCart => _isItemAddedToCart;

  int get productQuantity => _productQuantity;

  Product? get productData => _productData;

  List<String> get carouselImageList => _carouselImageList;

  List<String> get productSizeList => _productSizeList;

  List<String> get productColorList => _productColorList;

  set setIsBusy(bool value) {
    _isBusy = value;
    update();
  }

  set setIsAddingToCart(bool value) {
    _isAddingToCart = value;
    update();
  }

  set setIsItemAddedToCart(bool value) {
    _isItemAddedToCart = value;
    update();
  }

  set setSelectedColor(int index) {
    selectedColor = index;
    update();
  }

  set setSelectedSize(int index) {
    selectedSize = index;
    update();
  }

  void incrementProductQuantity() {
    _productQuantity++;
    update();
  }

  void decrementProductQuantity() {
    if (_productQuantity == 1) {
      return;
    }
    _productQuantity--;
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
          _productColorList =
              getProductColors(productDetailsModel.data![0].color.toString());
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

  Future<bool> createCartList(
      {required int productId, required String token}) async {
    _responseStatus = false;
    setIsAddingToCart = true;
    Map<String, dynamic> cartJson = {
      "product_id": productId,
      "color": getColorText(_productColorList[selectedColor]),
      "size": getSizeText(selectedSize),
    };
    cartResponse = await ProductService().createCartList(token, cartJson);
    if (cartResponse is Success) {
      //TODO I have to add cart api here later
      _responseStatus = true;
      _isItemAddedToCart = true;
    }
    setIsAddingToCart = false;
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

  List<String> getProductColors(String color) {
    List<String> colorList = color.split(",");
    List<String> refinedColorList = [];
    for (String color in colorList) {
      refinedColorList.add(color.substring(1, color.length));
    }
    return refinedColorList;
  }

  String getSizeText(int index) {
    Map<int, String> sizes = {
      0: "M",
      1: "L",
      2: "XL",
      3: "XXL",
    };
    return sizes[index] ?? "XXL";
  }

  String getColorText(String colorCode) {
    Map<String, String> colorCodes = {
      "212121": "Black",
      "0E98B1": "Cyan",
      "7A5548": "Brown",
      "D9D9D9": "White",
      "757575": "Grey",
    };
    return colorCodes[colorCode] ?? "Red";
  }

  void resetViewModel() {
    _carouselImageList.clear();
    _productSizeList.clear();
    _productColorList.clear();
    selectedSize = 0;
    selectedColor = 0;
    _productQuantity = 1;
    _isItemAddedToCart = false;
  }
}
