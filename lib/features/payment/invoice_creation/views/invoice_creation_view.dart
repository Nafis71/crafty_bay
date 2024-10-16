import 'package:crafty_bay/core/themes/app_color.dart';
import 'package:crafty_bay/core/utils/app_assets.dart';
import 'package:crafty_bay/core/wrappers/svg_image_loader.dart';
import 'package:crafty_bay/features/payment/invoice_creation/state_holders/invoice_creation_state.dart';
import 'package:crafty_bay/features/payment/invoice_creation/utils/invoice_creation_strings.dart';
import 'package:crafty_bay/features/payment/invoice_creation/views/card_banking.dart';
import 'package:crafty_bay/features/payment/invoice_creation/views/internet_banking.dart';
import 'package:crafty_bay/features/payment/invoice_creation/views/mobile_banking.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InvoiceCreationView extends StatefulWidget {
  const InvoiceCreationView({super.key});

  @override
  State<InvoiceCreationView> createState() => _InvoiceCreationViewState();
}

class _InvoiceCreationViewState extends State<InvoiceCreationView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(230),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 30),
              child: Column(
                children: [
                  SvgImageLoader(
                    assetLocation: AppAssets.appLogo,
                    boxFit: BoxFit.contain,
                    width: 90,
                  ),
                  Gap(50),
                  TabBar(
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorWeight: 0.5,
                    dividerColor: Colors.grey.shade100,
                    automaticIndicatorColorAdjustment: true,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(fontSize: 14),
                    overlayColor:
                        WidgetStateProperty.resolveWith<Color>((state) {
                      return AppColor.appSecondaryColor;
                      ;
                    }),
                    labelPadding: const EdgeInsets.all(2),
                    splashBorderRadius: BorderRadius.circular(5),
                    tabs: [
                      Tab(
                        text: InvoiceCreationStrings.mobileBankingTabText,
                      ),
                      Tab(
                        text: InvoiceCreationStrings.internetBankingTabText,
                      ),
                      Tab(
                        text: InvoiceCreationStrings.cardTabText,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 8,
                child: TabBarView(
                  children: [
                    MobileBanking(),
                    InternetBanking(),
                    CardBanking(),
                  ],
                ),
              ),
              Expanded(
                child: GetBuilder<InvoiceCreationState>(
                  builder: (invoiceCreationState) {
                    return Container(
                      height: 20,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Pay \$${invoiceCreationState.totalPayable}",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 18),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}