import 'package:crafty_bay/common/services/response/success.dart';
import 'package:crafty_bay/features/cart/models/cart_list_model/cart_data.dart';
import 'package:crafty_bay/features/cart/models/cart_list_model/cart_list_model.dart';
import 'package:crafty_bay/features/cart/services/cart_service.dart';
import 'package:crafty_bay/features/product_details/models/product.dart';
import 'package:crafty_bay/features/product_details/services/product_service.dart';
import 'package:get/get.dart';

class CartViewModel extends GetxController {
  Object? response;
  Object? deleteResponse;
  bool _isBusy = false;
  bool _responseStatus = false;
  final List<CartData> _cartList = [];
  final List<Product> _cartProductData = [];
  int totalPrice = 0;

  bool get isBusy => _isBusy;

  List<CartData> get cartList => _cartList;

  List<Product> get cartProductData => _cartProductData;

  Future<bool> getCartList(String token) async {
    _responseStatus = false;
    if (_cartList.isEmpty) {
      _isBusy = true;
    }
    response = await CartService().getCartList(token);
    if (response is Success) {
      _cartList.clear();
      _cartProductData.clear();
      totalPrice = 0;
      CartListModel cartListModel = CartListModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      for (CartData cartData in cartListModel.cartData!) {
        _cartList.add(cartData);
        response = await ProductService().getProductDetails(
          cartData.productId.toString(),
        );
        if (response is Success) {
          Map<String, dynamic> jsonData =
              (response as Success).response as Map<String, dynamic>;
          Map<String, dynamic> productJson = jsonData['data'][0]['product'];
          Product product = Product.fromJson(productJson);
          totalPrice += int.parse(product.price.toString());
          _cartProductData.add(product);
        }
      }
      _responseStatus = true;
    }
    _isBusy = false;
    update();
    return _responseStatus;
  }

  Future<bool> deleteCartItem({
    required int cartId,
    required String token,
    required int deleteIndex,
  }) async {
    _responseStatus = false;
    CartData tempCartData = _cartList[deleteIndex];
    Product tempProductData = _cartProductData[deleteIndex];
    _cartList.removeAt(deleteIndex);
    _cartProductData.removeAt(deleteIndex);
    int productPrice = int.parse(tempProductData.price.toString());
    totalPrice -= productPrice;
    update();
    deleteResponse =
        await CartService().deleteCartItem(cartId.toString(), token);
    if (deleteResponse is Success) {
      _responseStatus = true;
    } else {
      _cartList.insert(deleteIndex, tempCartData);
      _cartProductData.insert(deleteIndex, tempProductData);
      totalPrice += productPrice;
      update();
    }
    return _responseStatus;
  }
}
