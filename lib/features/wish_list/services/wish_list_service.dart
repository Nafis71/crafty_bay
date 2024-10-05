import 'package:crafty_bay/core/services/network_repository.dart';
import 'package:crafty_bay/core/services/network_urls/network_urls.dart';

class WishListService extends NetworkRepository {
  static WishListService? _instance;

  WishListService._();

  factory WishListService() => _instance ??= WishListService._();

  Future<Object> createWishList(String productId, String token) async {
    return await getRequest(
      url: "${NetworkUrls.createWishList}/$productId",
      headers: {"token": token},
    );
  }

  Future<Object> getWishList(String token) async {
    return await getRequest(
      url: NetworkUrls.productWishList,
      headers: {"token": token},
    );
  }

  Future<Object> removeWishList(String token, int id) async {
    return await getRequest(
      url: "${NetworkUrls.removeWishList}/$id",
      headers: {"token": token},
    );
  }
}
