import 'package:crafty_bay/core/services/network_repository.dart';
import 'package:crafty_bay/core/services/network_urls/network_urls.dart';

class CartService extends NetworkRepository {
  static CartService? _instance;

  CartService._();

  factory CartService() => _instance ??= CartService._();

  Future<Object> getCartList(String token) async {
    return await getRequest(
      url: NetworkUrls.cartList,
      headers: {"token": token},
    );
  }

  Future<Object> deleteCartItem(String cartId, String token) async {
    return await getRequest(
      url: "${NetworkUrls.deleteCartList}/$cartId",
      headers: {
        "token": token,
      },
    );
  }

  Future<Object> createCartList(
      String token, Map<String, dynamic> cartJson) async {
    return await postRequest(
      url: NetworkUrls.createCartList,
      headers: {"content-type": "Application/json", "token": token},
      body: cartJson,
    );
  }
}
