import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:crafty_bay/features/product_details/views/product_details_view/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../product_details/state_holders/product_state.dart';
import '../state_holders/home_state.dart';
import '../state_holders/offer_carousel_state.dart';

class OfferCarousel extends StatefulWidget {
  const OfferCarousel({super.key});

  @override
  State<OfferCarousel> createState() => _OfferCarouselState();
}

class _OfferCarouselState extends State<OfferCarousel> {
  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: Get.find<HomeState>().productSliderList.length,
      itemBuilder: (context, index, pageViewIndex) {
        return CachedNetworkImage(
          imageUrl: Get.find<HomeState>().productSliderList[index].image!,
          imageBuilder: (context, imageProvider) {
            return Container(
              margin:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 7),
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(45),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(45),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Gap(10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Get.find<HomeState>()
                                      .productSliderList[index]
                                      .title!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                const Gap(10),
                                SizedBox(
                                  width: 120,
                                  height: 40,
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
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsView(
                                            productId: Get.find<HomeState>()
                                                .productSliderList[index]
                                                .productId!,
                                          ),
                                        ),
                                      ).then((value) {
                                        Get.find<ProductState>()
                                            .resetViewModel();
                                      });
                                    },
                                    child: Text(
                                      AppStrings.offerCarouselButtonText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
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
          Get.find<OfferCarouselState>().setCarouselIndex = index;
        },
      ),
    );
  }
}
