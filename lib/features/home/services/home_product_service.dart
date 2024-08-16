import 'package:crafty_bay/common/services/api_request.dart';
import 'package:crafty_bay/common/services/network_urls/network_urls.dart';

class HomeProductService extends ApiRequest {
  static HomeProductService? _instance;

  HomeProductService._();

  factory HomeProductService() => _instance ??= HomeProductService._();

  Future<Object> getProductSliderList() async {
    return getRequest(url: NetworkUrls.productSlider);
  }

  Future<Object> getProductByRemark(String remark) async {
    return getRequest(url: "${NetworkUrls.listProductByRemark}/$remark");
  }
}
