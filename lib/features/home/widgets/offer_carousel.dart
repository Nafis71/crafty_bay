import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:crafty_bay/utils/app_assets.dart';
import 'package:crafty_bay/wrappers/svg_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OfferCarousel extends StatelessWidget {
  const OfferCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: 4,
      itemBuilder: (context, index, pageViewIndex) {
        return Card(
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(2.5),
              const SvgImageLoader(
                  assetLocation: AppAssets.appLogo, boxFit: BoxFit.cover),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Happy New Year Special Deal\nSave 30%",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Gap(10),
                    SizedBox(
                      width: 120,
                      height: 38,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Theme.of(context).primaryColor,
                            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 13,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)
                            )
                          ),
                          onPressed: () {}, child: const Text("Buy Now")),
                    )
                  ],
                ),
              ),
              const Gap(2.5),
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
        onPageChanged: (index,_){
          Get.find<HomeViewModel>().setCarouselIndex = index;
        }
      ),
    );
  }
}
