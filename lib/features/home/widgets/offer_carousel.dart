import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:crafty_bay/features/product_details/views/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OfferCarousel extends StatefulWidget {
  const OfferCarousel({super.key});

  @override
  State<OfferCarousel> createState() => _OfferCarouselState();
}

class _OfferCarouselState extends State<OfferCarousel> {
  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: Get.find<HomeViewModel>().productSliderList.length,
      itemBuilder: (context, index, pageViewIndex) {
        return Card(
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(5),
              Expanded(
                child: Center(
                  child: Image.network(
                    Get.find<HomeViewModel>().productSliderList[index].image!,
                    fit: BoxFit.contain,
                    width: 170,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Get.find<HomeViewModel>()
                              .productSliderList[index]
                              .title!,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Gap(10),
                        SizedBox(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor:
                                      Theme.of(context).primaryColor,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 13,
                                      ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsView(
                                      productId: Get.find<HomeViewModel>()
                                          .productSliderList[index]
                                          .productId!,
                                    ),
                                  ),
                                ).then((value){
                                  Get.find<ProductViewModel>().resetViewModel();
                                });
                              },
                              child: const Text("Buy Now")),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 180,
        viewportFraction: 1,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        indicatorMargin: 10,
        showIndicator: false,
        onPageChanged: (index, _) {
          Get.find<HomeViewModel>().setCarouselIndex = index;
        },
      ),
    );
  }
}
