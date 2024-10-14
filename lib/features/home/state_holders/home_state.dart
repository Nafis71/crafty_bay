import 'package:crafty_bay/core/services/response/success.dart';
import 'package:crafty_bay/features/home/models/product_slider_model/product_data.dart';
import 'package:crafty_bay/features/home/models/product_slider_model/product_slider.dart';
import 'package:crafty_bay/features/home/models/remark_product_model/remark_product_data.dart';
import 'package:crafty_bay/features/home/models/remark_product_model/remark_product_model.dart';
import 'package:crafty_bay/features/home/services/home_product_service.dart';
import 'package:get/get.dart';

class HomeState extends GetxController {
  Object? response;
  final List<ProductSliderData> _productSliderList = [];
  List<RemarkProductData> _popularProductList = [];
  List<RemarkProductData> _specialProductList = [];
  List<RemarkProductData> _newProductList = [];
  List<RemarkProductData> _searchProductList = [];

  List<ProductSliderData> get productSliderList => _productSliderList;

  List<RemarkProductData> get popularProductList => _popularProductList;

  List<RemarkProductData> get specialProductList => _specialProductList;

  List<RemarkProductData> get newProductList => _newProductList;

  List<RemarkProductData> get searchProductList => _searchProductList;

  Future<bool> getProductSliderList() async {
    response = await HomeProductService().getProductSliderList();
    if (response is Success) {
      _productSliderList.clear();
      ProductSlider productSliderModel = ProductSlider.fromJson(
          (response as Success).response as Map<String, dynamic>);
      for (ProductSliderData productSliderData in productSliderModel.data!) {
        _productSliderList.add(productSliderData);
      }
      return true;
    }
    return false;
  }

  Future<bool> getPopularProduct() async {
    RemarkProductModel? remarkProductModel =
        await getProductByRemark("popular");
    if (remarkProductModel != null) {
      _popularProductList = await getProductList(remarkProductModel);
      _searchProductList.addAll(_popularProductList);
      return true;
    }
    return false;
  }

  Future<bool> getSpecialProduct() async {
    RemarkProductModel? remarkProductModel =
        await getProductByRemark("special");
    if (remarkProductModel != null) {
      _specialProductList = await getProductList(remarkProductModel);
      _searchProductList.addAll(_specialProductList);
      return true;
    }
    return false;
  }

  Future<bool> getNewProduct() async {
    RemarkProductModel? remarkProductModel = await getProductByRemark("new");
    if (remarkProductModel != null) {
      _newProductList = await getProductList(remarkProductModel);
      _searchProductList.addAll(_newProductList);
      return true;
    }
    return false;
  }

  Future<List<RemarkProductData>> getProductList(
      RemarkProductModel remarkProductModel) async {
    List<RemarkProductData> productData = [];
    for (RemarkProductData popularProductData in remarkProductModel.data!) {
      productData.add(popularProductData);
    }
    return productData;
  }

  Future<RemarkProductModel?> getProductByRemark(String remark) async {
    response = await HomeProductService().getProductByRemark(remark);
    if (response is Success) {
      RemarkProductModel remarkProductModel = RemarkProductModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      return remarkProductModel;
    }
    return null;
  }
}
