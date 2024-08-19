import 'package:crafty_bay/common/services/response/success.dart';
import 'package:crafty_bay/features/cart/models/cart_list_model/cart_data.dart';
import 'package:crafty_bay/features/cart/models/cart_list_model/cart_list_model.dart';
import 'package:crafty_bay/features/cart/services/cart_service.dart';
import 'package:get/get.dart';

class CartViewModel extends GetxController {
  Object? response;
  bool _isBusy = false;
  bool _responseStatus = false;
  final List<CartData> _cartList = [];

  bool get isBusy => _isBusy;

  List<CartData> get cartList => _cartList;

  Future<bool> getCartList(String token) async {
    _responseStatus = false;
    _isBusy = true;
    response = await CartService().getCartList(token);
    if (response is Success) {
      CartListModel cartListModel = CartListModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      for (CartData cartData in cartListModel.cartData!) {
        _cartList.add(cartData);
      }
      _responseStatus = true;
    }
    _isBusy = false;
    update();
    return _responseStatus;
  }
}
