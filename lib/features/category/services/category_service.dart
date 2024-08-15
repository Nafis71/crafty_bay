import 'package:crafty_bay/services/api_request.dart';

import '../../../services/network_urls/network_urls.dart';

class CategoryService extends ApiRequest {
  static CategoryService? _instance;

  CategoryService._();

  factory CategoryService() => _instance ??= CategoryService._();

  Future<Object> getCategoryList() async {
    return getRequest(url: NetworkUrls.categoryList);
  }
}
