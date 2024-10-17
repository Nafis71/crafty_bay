import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/grid_view_layout.dart';
import '../models/payment_method.dart';

class PaymentMethods extends StatelessWidget {
  final List<PaymentMethod> paymentMethods;
  final int selectedIndex;
  final Function(int) onTap;

  const PaymentMethods(
      {super.key, required this.paymentMethods, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridViewLayout(
      length: paymentMethods.length,
      child: (index) {
        return CachedNetworkImage(
          imageUrl: paymentMethods[index].logo.toString().toString(),
          errorWidget: (context, string, _) {
            return Icon(
              Icons.error,
              color: Colors.red,
            );
          },
          imageBuilder: (context, imageProvider) {
            return InkWell(
              onTap: ()=> onTap(index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: (selectedIndex == index)
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade100,
                      width: 1.5
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      mainAxisExtent: 60,
      crossAxisExtent: 60,
    );
  }
}
