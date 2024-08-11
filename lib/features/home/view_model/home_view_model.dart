import 'package:get/get.dart';

class HomeViewModel extends GetxController{
  int _carouselIndex = 0;

  int get carouselIndex => _carouselIndex;

  set setCarouselIndex(int index){
    _carouselIndex = index;
    update();
  }
}