import 'package:crafty_bay/features/cart/state_holders/cart_view_state.dart';
import 'package:crafty_bay/features/payment/invoice_creation/models/payment_method.dart';
import 'package:crafty_bay/features/payment/payment_webView/utils/payment_webView_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewState extends GetxController {
  bool _isPaymentSuccess = false;
  bool _isPaymentPending = true;
  bool _isBusy = true;

  bool get isBusy => _isBusy;

  bool get isPaymentSuccess => _isPaymentSuccess;

  bool get isPaymentPending => _isPaymentPending;

  CartViewState cartViewState;

  PaymentWebViewState(this.cartViewState);

  WebViewController configureController(PaymentMethod paymentMethod) {
    try{
      return WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onHttpError: (HttpResponseError error) {},
            onWebResourceError: (WebResourceError error) {},
            onPageFinished: (String url) {
              if (url.startsWith(PaymentWebViewStrings.paymentSuccessfulUrl)) {
                paymentSuccessTask();
              }
              if (url.startsWith(PaymentWebViewStrings.paymentFailureUrl)) {
                paymentFailureTask();
              }
            },
            onNavigationRequest: (NavigationRequest navigationRequest) {
              if(navigationRequest.url.startsWith("null")){
                paymentFailureTask();
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(
          Uri.parse(
            paymentMethod.redirectGatewayURL.toString(),
          ),
        );
    }catch(exception){
      if(kDebugMode){
        debugPrint("Browser Exception Occurred - ${exception.toString()}");
        paymentFailureTask();
      }
    }
    return WebViewController();
  }

  Future<void> paymentSuccessTask() async {
    _isPaymentSuccess = true;
    _isPaymentPending = false;
    _isBusy = true;
    update();
    await cartViewState.removeAllCartProduct();
    _isBusy = false;
    update();
  }

  Future<void> paymentFailureTask() async {
    _isPaymentSuccess = false;
    _isPaymentPending = false;
    await Future.delayed(Duration(seconds: 2));
    update();
  }

  void resetPaymentWebViewState(){
     _isPaymentSuccess = false;
     _isPaymentPending = true;
  }

}
