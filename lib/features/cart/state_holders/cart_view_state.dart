import 'package:crafty_bay/core/services/response/success.dart';
import 'package:crafty_bay/features/cart/models/cart_list_model/cart_data.dart';
import 'package:crafty_bay/features/cart/models/cart_list_model/cart_list_model.dart';
import 'package:crafty_bay/features/cart/services/cart_service.dart';
import 'package:get/get.dart';

import '../../product_details/state_holders/product_state.dart';

class CartViewState extends GetxController {
  Object? response;
  Object? deleteResponse;
  bool _isBusy = false;
  bool _responseStatus = false;
  List<CartData> _cartList = [];
  int totalPrice = 0;
  ProductState productState;

  CartViewState(this.productState);

  bool get isBusy => _isBusy;

  List<CartData> get cartList => _cartList;

  Future<bool> getCartList(String token) async {
    _responseStatus = false;
    if (_cartList.isEmpty) {
      _isBusy = true;
      update();
    }
    response = await CartService().getCartList(token);
    if (response is Success) {
      _cartList.clear();
      totalPrice = 0;
      CartListModel cartListModel = CartListModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      for (CartData cartData in cartListModel.cartData!) {
        _cartList.add(cartData);
      }
      _cartList = _cartList.reversed.toList();
      calculateTotalCartPrice();
      _responseStatus = true;
    }
    _isBusy = false;
    update();
    return _responseStatus;
  }

  Future<bool> createCartList(
      {required int productId, required String token}) async {
    _responseStatus = false;
    productState.setIsAddingToCart = true;
    Map<String, dynamic> cartJson = {
      "product_id": productId,
      "color": productState.getColorText(
          productState.productColorList[productState.selectedColor]),
      "size": productState.getSizeText(productState.selectedSize),
      "qty": productState.productQuantity
    };
    response = await CartService().createCartList(token, cartJson);
    if (response is Success) {
      await Get.find<CartViewState>().getCartList(token);
      _responseStatus = true;
      productState.setIsItemAddedToCart = true;
    }
    productState.setIsAddingToCart = false;
    return _responseStatus;
  }

  Future<bool> updateCartList(int index, String token, bool isIncrement) async {
    _responseStatus = false;
    int productQuantity = int.parse(cartList[index].qty!);
    Map<String, dynamic> cartJson = {
      "product_id": cartList[index].productId!,
      "color": cartList[index].color,
      "size": cartList[index].size,
      "qty": (isIncrement) ? productQuantity + 1 : productQuantity - 1
    };
    response = await CartService().createCartList(token, cartJson);
    if (response is Success) {
      int productUnitPrice = int.parse(cartList[index].cartProductData!.price!);
      int productTotalPrice = int.parse(cartList[index].price!);
      if (!isIncrement) {
        cartList[index].qty = (productQuantity - 1).toString();
        cartList[index].price =
            (productTotalPrice - productUnitPrice).toString();
      } else {
        cartList[index].qty = (productQuantity + 1).toString();
        cartList[index].price =
            (productTotalPrice + productUnitPrice).toString();
      }
      calculateTotalCartPrice();
      _responseStatus = true;
      update();
    }
    return _responseStatus;
  }

  Future<bool> deleteCartItem({
    required int cartId,
    required String token,
    required int deleteIndex,
  }) async {
    _responseStatus = false;
    CartData tempCartData = _cartList[deleteIndex];
    _cartList.removeAt(deleteIndex);
    int productPrice = int.parse(tempCartData.price.toString());
    totalPrice -= productPrice;
    update();
    deleteResponse =
        await CartService().deleteCartItem(cartId.toString(), token);
    if (deleteResponse is Success) {
      _responseStatus = true;
    } else {
      _cartList.insert(deleteIndex, tempCartData);
      totalPrice += productPrice;
      update();
    }
    return _responseStatus;
  }

  void calculateTotalCartPrice() {
    totalPrice = 0;
    for (CartData cartData in cartList) {
      totalPrice += int.parse(cartData.price!);
    }
  }
}
