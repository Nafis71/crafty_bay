import 'package:crafty_bay/core/utils/app_assets.dart';
import 'package:crafty_bay/features/payment/invoice_creation/models/payment_method.dart';
import 'package:crafty_bay/features/payment/payment_webView/state_holders/payment_webView_state.dart';
import 'package:crafty_bay/features/payment/payment_webView/utils/payment_webView_strings.dart';
import 'package:crafty_bay/features/payment/payment_webView/widgets/payment_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final PaymentMethod paymentMethod;

  const PaymentWebView({super.key, required this.paymentMethod});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 5,
      ),
      body: GetBuilder<PaymentWebViewState>(
        builder: (paymentWebViewState) {
          if (paymentWebViewState.isPaymentPending) {
            return PopScope(
              canPop: false,
              child: WebViewWidget(
                controller: paymentWebViewState.configureController(
                  widget.paymentMethod,
                ),
              ),
            );
          }
          if (paymentWebViewState.isPaymentSuccess) {
            if (paymentWebViewState.isBusy) {
              return Center(
                child: Lottie.asset(AppAssets.cartLottie, width: 80),
              );
            }
            return PaymentStatus(
              //payment success
              animationAsset: AppAssets.paymentSuccess,
              headerText: PaymentWebViewStrings.paymentSuccessfulHeaderText,
              subtitleText: PaymentWebViewStrings.paymentSuccessfulSubtitleText,
            );
          }
          return PaymentStatus(
            //payment failed
            animationAsset: AppAssets.paymentFailure,
            headerText: PaymentWebViewStrings.paymentFailureHeaderText,
            subtitleText: PaymentWebViewStrings.paymentFailureSubtitleText,
          );
        },
      ),
    );
  }
}
