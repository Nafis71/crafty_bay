import 'package:crafty_bay/core/services/network_service/network_repository.dart';

import '../../../core/utils/network_urls.dart';

class CategoryService extends NetworkRepository {
  static CategoryService? _instance;

  CategoryService._();

  factory CategoryService() => _instance ??= CategoryService._();

  Future<Object> getCategoryList() async {
    return getRequest(url: NetworkUrls.categoryList);
  }

  Future<Object> getProductByCategory(String categoryId) async {
    return getRequest(url: "${NetworkUrls.listProductByCategory}/$categoryId");
  }
}
