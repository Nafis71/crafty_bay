import 'package:crafty_bay/features/payment/invoice_creation/models/payment_method.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewState extends GetxController {
  bool _isPaymentSuccess = false;
  bool _isPaymentPending = true;

  bool get isPaymentSuccess => _isPaymentSuccess;

  bool get isPaymentPending => _isPaymentPending;

  WebViewController configureController(PaymentMethod paymentMethod) {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onPageFinished: (String url) {
            if (url.startsWith(
                "https://ecommerce-api.codesilicon.com/api/PaymentSuccess")) {
              _isPaymentSuccess = true;
              _isPaymentPending = false;
            }
            if (url.startsWith(
                "https://ecommerce-api.codesilicon.com/api/PaymentFail")) {
              _isPaymentSuccess = false;
              _isPaymentPending = false;
            }
          },
          onNavigationRequest: (NavigationRequest navigationRequest) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          paymentMethod.redirectGatewayURL.toString(),
        ),
      );
  }
}
