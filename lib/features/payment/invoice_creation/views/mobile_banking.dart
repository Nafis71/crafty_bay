import 'package:crafty_bay/features/payment/invoice_creation/models/payment_type_enum.dart';
import 'package:crafty_bay/features/payment/invoice_creation/state_holders/invoice_creation_state.dart';
import 'package:crafty_bay/features/payment/invoice_creation/utils/invoice_creation_strings.dart';
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
          return Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
            child: Column(
              children: [
                Expanded(
                  child: PaymentMethods(
                    paymentMethods: invoiceCreationState.paymentMethodsMobile,
                    selectedIndex: invoiceCreationState
                        .getSelectedPaymentIndex(PaymentType.mobileBanking),
                    onTap: (index) {
                      invoiceCreationState.setSelectedPaymentIndex(
                        index,
                        PaymentType.mobileBanking,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
