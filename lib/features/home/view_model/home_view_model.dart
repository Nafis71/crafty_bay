import 'package:crafty_bay/features/home/models/product_data.dart';
import 'package:crafty_bay/features/home/models/product_slider.dart';
import 'package:crafty_bay/features/home/services/home_product_service.dart';
import 'package:crafty_bay/services/response/success.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  int _carouselIndex = 0;
  Object? response;
  final List<ProductSliderData> _productSliderList = [];

  int get carouselIndex => _carouselIndex;

  List<ProductSliderData> get productSliderList => _productSliderList;

  set setCarouselIndex(int index) {
    _carouselIndex = index;
    update();
  }

  Future<void> getProductSliderList() async {
    response = await HomeProductService().getProductSliderList();
    if (response is Success) {
      ProductSlider productSliderModel = ProductSlider.fromJson(
          (response as Success).response as Map<String, dynamic>);
      for(ProductSliderData productSliderData in productSliderModel.data!){
        _productSliderList.add(productSliderData);
      }
    }
  }
}
