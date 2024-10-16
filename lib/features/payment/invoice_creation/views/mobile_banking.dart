import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/core/widgets/grid_view_layout.dart';
import 'package:crafty_bay/features/payment/invoice_creation/state_holders/invoice_creation_state.dart';
import 'package:crafty_bay/features/payment/invoice_creation/widgets/payment_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileBanking extends StatefulWidget {
  const MobileBanking({super.key});

  @override
  State<MobileBanking> createState() => _MobileBankingState();
}

class _MobileBankingState extends State<MobileBanking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InvoiceCreationState>(
        builder: (invoiceCreationState) {
          return PaymentMethods(
            paymentMethods: invoiceCreationState.paymentMethodsMobile,
          );
        },
      ),
    );
  }
}