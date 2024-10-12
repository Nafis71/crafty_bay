import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';

import '../../../core/themes/app_color.dart';

class ProductImageCarousel extends StatelessWidget {
  final Orientation orientation;
  final List<String> carouselImageList;

  const ProductImageCarousel(
      {super.key, required this.orientation, required this.carouselImageList});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: carouselImageList.length,
      itemBuilder: (context, index, pageIndex) {
        return CachedNetworkImage(
          imageUrl: carouselImageList[index],
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                  color: AppColor.productCarouselBackgroundColor,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(40),
                ],
              ),
            );
          },
        );
      },
      options: CarouselOptions(
        viewportFraction: 1,
        aspectRatio: (orientation == Orientation.portrait) ? 1.7 : 3,
        initialPage: 0,
        indicatorMargin: 20,
        slideIndicator: CircularSlideIndicator(
          slideIndicatorOptions: SlideIndicatorOptions(
            currentIndicatorColor: Theme.of(context).primaryColor,
            indicatorRadius: 8,
            itemSpacing: 23,
            indicatorBackgroundColor: Colors.white,
            enableAnimation: true,
          ),
        ),
      ),
    );
  }
}
