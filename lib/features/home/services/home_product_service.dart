import 'package:crafty_bay/core/services/network_repository.dart';
import 'package:crafty_bay/core/services/network_urls/network_urls.dart';

class HomeProductService extends NetworkRepository {
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
