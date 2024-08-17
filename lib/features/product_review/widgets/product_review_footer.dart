import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';

class ProductReviewFooter extends StatelessWidget {
  final int totalReview;

  const ProductReviewFooter({super.key, required this.totalReview});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.only(top: 5,left: 30,right: 30),
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
              Text(
                "Reviews ($totalReview)",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.6)),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      )
                    ]
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.add,color: Colors.white,),
                )
              )
            ],
          ),
        ],
      ),
    );
  }
}
