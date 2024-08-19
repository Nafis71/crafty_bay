import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';

class CartListFooter extends StatelessWidget {
  const CartListFooter({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
      decoration: BoxDecoration(
        color: AppColor.appSecondaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Price",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          fontFamily: "Poppins Medium",
                          color: Colors.black.withOpacity(0.5),
                        ),
                  ),
                  Text(
                    "\$100000",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.35,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Checkout",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 13, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
