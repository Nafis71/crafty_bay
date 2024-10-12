import 'package:crafty_bay/core/services/response/success.dart';
import 'package:crafty_bay/features/product_details/models/product.dart';
import 'package:crafty_bay/features/product_details/models/product_details_model.dart';
import 'package:crafty_bay/features/product_details/services/product_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductState extends GetxController {
  Object? response;
  Object? cartResponse;
  Product? _productData;
  final List<String> _carouselImageList = [];
  List<String> _productSizeList = [];
  List<int> _productColorList = [];
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

  List<int> get productColorList => _productColorList;

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
    if (isProductExist(productId)) {
      return true;
    }
    resetViewModel();
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
          _productData?.description = productDetailsModel.data![0].des;
          _responseStatus = true;
        }
      } catch (exception) {
        if (kDebugMode) {
          debugPrint(
              "Exception caught from product details fetching ${exception.toString()}");
        }
      }
    }
    setIsBusy = false;
    return _responseStatus;
  }

  bool isProductExist(int productId) {
    if (productData != null && productData!.id == productId) {
      return true;
    }
    return false;
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

  List<int> getProductColors(String color) {
    Map<String, int> colorCodes = {
      "red": 0xFFE71A23,
      "green": 0xFF007C00,
      "white": 0xFFD9D9D9
    };
    List<String> colorList = color.split(",");
    List<int> refinedColorList = [];
    for (String color in colorList) {
      refinedColorList.add(colorCodes[color.toLowerCase()]!);
    }
    return refinedColorList;
  }

  String getSizeText(int index) {
    Map<int, String> sizes = {
      0: "X",
      1: "2X",
      2: "3X",
    };
    return sizes[index] ?? "X";
  }

  String getColorText(int colorCode) {
    Map<int, String> colorCodes = {
      0xFF890104: "Red",
      0xFF007C00: "Green",
      0xFFD9D9D9: "White",
    };
    return colorCodes[colorCode] ?? "Red";
  }

  void resetViewModel() {
    _carouselImageList.clear();
    _productSizeList.clear();
    _productColorList.clear();
    _productData = null;
    selectedSize = 0;
    selectedColor = 0;
    _productQuantity = 1;
    _isItemAddedToCart = false;
  }
}
