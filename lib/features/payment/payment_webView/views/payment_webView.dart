import 'package:crafty_bay/features/payment/invoice_creation/models/payment_method.dart';
import 'package:crafty_bay/features/payment/payment_webView/state_holders/payment_webView_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final PaymentMethod paymentMethod;

  const PaymentWebView({super.key, required this.paymentMethod});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<PaymentWebViewState>(
        builder: (paymentWebViewState) {
          return WebViewWidget(
            controller: paymentWebViewState.configureController(
              widget.paymentMethod,
            ),
          );
        },
      ),
    );
  }
}
