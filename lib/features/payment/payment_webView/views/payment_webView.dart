import 'package:crafty_bay/features/payment/invoice_creation/models/payment_method.dart';
import 'package:flutter/material.dart';

class PaymentWebView extends StatefulWidget {
  final PaymentMethod paymentMethod;
  const PaymentWebView({super.key, required this.paymentMethod});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
