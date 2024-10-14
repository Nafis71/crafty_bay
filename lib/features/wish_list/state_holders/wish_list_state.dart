import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/services/response/success.dart';
import 'package:crafty_bay/features/wish_list/models/WishListData.dart';
import 'package:crafty_bay/features/wish_list/models/WishListProductData.dart';
import 'package:crafty_bay/features/wish_list/services/wish_list_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class WishListState extends GetxController {
  Object? response;
  final List<int> _wishListProductId = [];
  final List<WishListProductData> _wishListProductData = [];
  bool _isBusy = false;
  bool _responseStatus = false;

  bool get isBusy => _isBusy;

  List<int> get wishListProductId => _wishListProductId;

  List<WishListProductData> get productWishList => _wishListProductData;

  Future<void> createWishList(int productId, String token) async {
    _responseStatus = false;
    _wishListProductId.add(productId);
    update();
    response =
        await WishListService().createWishList(productId.toString(), token);
    if (response is Failure) {
      _wishListProductId.remove(productId);
      update();
      return;
    }
    await getWishList(token);
    update();
  }

  Future<bool> getWishList(String token) async {
    print(token);
    _responseStatus = false;
    _isBusy = true;
    response = await WishListService().getWishList(token);
    if (response is Success) {
      _wishListProductData.clear();
      _wishListProductId.clear();
      Map<String, dynamic> jsonData =
          (response as Success).response as Map<String, dynamic>;
      List<dynamic> listOfWishList = jsonData['data'];
      for (Map<String, dynamic> wishList in listOfWishList) {
        WishListData wishListData = WishListData.fromJson(wishList);
        _wishListProductId.add(wishListData.productId!);
        _wishListProductData.add(wishListData.wishListProductData!);
      }
      _responseStatus = true;
    }
    _isBusy = false;
    update();
    return _responseStatus;
  }

  Future<bool> removeWishList(String token, int productId) async {
    _responseStatus = false;
    try {
      WishListProductData tempWishListProductData = _wishListProductData
          .firstWhere((productData) => productData.id == productId);
      _wishListProductData
          .removeWhere((productData) => productData.id == productId);
      _wishListProductId
          .removeWhere((wishListProductId) => wishListProductId == productId);
      update();
      response = await WishListService().removeWishList(token, productId);
      if (response is Failure) {
        _wishListProductData.insert(0, tempWishListProductData);
        _wishListProductId.add(productId);
      } else {
        _responseStatus = true;
      }
      update();
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      update();
      return _responseStatus;
    }
    return _responseStatus;
  }
}
