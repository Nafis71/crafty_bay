import 'package:crafty_bay/common/services/network_repository.dart';
import 'package:crafty_bay/common/services/network_urls/network_urls.dart';

class CartService extends NetworkRepository {
  static CartService? _instance;

  CartService._();

  factory CartService() => _instance ??= CartService._();

  Future<Object> getCartList(String token) async {
    return getRequest(
      url: NetworkUrls.cartList,
      headers: {"token": token},
    );
  }
}
