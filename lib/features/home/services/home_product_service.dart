import 'package:crafty_bay/services/api_request.dart';
import 'package:crafty_bay/services/network_urls/network_urls.dart';

class HomeProductService extends ApiRequest {
  static HomeProductService? _instance;

  HomeProductService._();

  factory HomeProductService() => _instance ??= HomeProductService._();

  Future<Object> getProductSliderList() async {
    return getRequest(url: NetworkUrls.productSlider);
  }

  Future<Object> getCategoryList() async{
    return getRequest(url: NetworkUrls.categoryList);
  }

  Future<Object> listProductByRemark(String remark) async{
    return getRequest(url: "${NetworkUrls.listProductByRemark}/$remark");
  }
}
