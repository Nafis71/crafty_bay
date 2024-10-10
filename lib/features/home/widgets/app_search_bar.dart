import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:crafty_bay/themes/theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'custom_search_delegate.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Get.find<HomeViewModel>().searchProductList.isEmpty) {
          return;
        }
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(),
        );
      },
      child: GetBuilder<ThemeSwitcher>(
        builder: (themeSwitcher) {
          return Card(
            color: themeSwitcher.getSearchBarColor(),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.search,
                    color: Colors.grey.shade700,
                  ),
                  const Gap(4),
                  Text(
                    "Search",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
