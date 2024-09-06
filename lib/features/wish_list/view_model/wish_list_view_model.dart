import 'package:crafty_bay/common/services/response/failure.dart';
import 'package:crafty_bay/common/services/response/success.dart';
import 'package:crafty_bay/features/product_details/models/product.dart';
import 'package:crafty_bay/features/product_details/services/product_service.dart';
import 'package:crafty_bay/features/wish_list/models/wish_list_model.dart';
import 'package:crafty_bay/features/wish_list/services/wish_list_service.dart';
import 'package:get/get.dart';

class WishListViewModel extends GetxController {
  Object? response;
  final List<int> _wishListProductId = [];
  final List<Product> _productWishList = [];
  bool _isBusy = false;
  bool _responseStatus = false;

  bool get isBusy => _isBusy;

  List<int> get wishListProductId => _wishListProductId;

  List<Product> get productWishList => _productWishList;

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
    await getProductData(productId);
    update();
  }

  Future<bool> getWishList(String token) async {
    print(token);
    _responseStatus = false;
    _isBusy = true;
    response = await WishListService().getWishList(token);
    if (response is Success) {
      _productWishList.clear();
      _wishListProductId.clear();
      Map<String, dynamic> jsonData =
          (response as Success).response as Map<String, dynamic>;
      List<dynamic> listOfWishList = jsonData['data'];
      for (Map<String, dynamic> wishList in listOfWishList) {
        WishListModel wishListModel = WishListModel.fromJson(wishList);
        _wishListProductId.add(wishListModel.productId!);
        await getProductData(wishListModel.productId!);
      }
      _responseStatus = true;
    }
    _isBusy = false;
    update();
    return _responseStatus;
  }

  Future<void> getProductData(int productId) async {
    response = await ProductService().getProductDetails(productId.toString());
    if (response is Success) {
      Map<String, dynamic> jsonData =
          (response as Success).response as Map<String, dynamic>;
      Map<String, dynamic> productJson = jsonData['data'][0]['product'];
      _productWishList.add(Product.fromJson(productJson));
    }
  }
}
