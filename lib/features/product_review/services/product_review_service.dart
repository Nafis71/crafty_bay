import 'package:crafty_bay/common/services/api_request.dart';
import 'package:crafty_bay/common/services/network_urls/network_urls.dart';

class ProductReviewService extends ApiRequest {
  static ProductReviewService? _instance;

  ProductReviewService._();

  factory ProductReviewService() => _instance ??= ProductReviewService._();

  Future<Object> getProductReview(String productId) async {
    return await getRequest(
      url: "${NetworkUrls.listReviewByProduct}/$productId",
    );
  }

  Future<Object> createReview(String token, Map<String, dynamic> review) async {
    return postRequest(
      url: NetworkUrls.createProductReview,
      headers: {"content-type": "Application/json", "token": token},
      body: review,
    );
  }
}
