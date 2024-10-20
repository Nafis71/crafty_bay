import 'package:get/get.dart';

class CompleteProfileViewState extends GetxController{
  bool _useSameShippingAddress = true;

  bool get useSameShippingAddress => _useSameShippingAddress;

  void toggleUseSameShippingAddress(){
    _useSameShippingAddress = !_useSameShippingAddress;
    update();
  }
}