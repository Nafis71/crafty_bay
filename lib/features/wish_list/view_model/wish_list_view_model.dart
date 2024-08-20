import 'package:crafty_bay/common/services/response/failure.dart';
import 'package:crafty_bay/common/services/response/success.dart';
import 'package:crafty_bay/features/wish_list/services/wish_list_service.dart';
import 'package:get/get.dart';

class WishListViewModel extends GetxController{
  Object? response;
  List<int> _wishListProductId = [];
  bool _isBusy = false;
  bool _responseStatus = false;

  bool get isBusy => _isBusy;
  List<int> get wishListProductId => _wishListProductId;

  Future<void> createWishList(int productId, String token) async{
    _responseStatus = false;
    _wishListProductId.add(productId);
    update();
    response = await WishListService().createWishList(productId.toString(), token);
    if(response is Failure){
      _wishListProductId.remove(productId);
      update();
    }
  }

}