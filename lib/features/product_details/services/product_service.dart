import 'package:crafty_bay/common/services/api_request.dart';
import 'package:crafty_bay/common/services/network_urls/network_urls.dart';

class ProductService extends ApiRequest {
  static ProductService? _instance;

  ProductService._();

  factory ProductService() => _instance ??= ProductService._();

  Future<Object> getProductDetails(String productId) async {
    return await getRequest(
      url: "${NetworkUrls.productDetailsById}/$productId",
    );
  }
}
