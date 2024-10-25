import 'package:crafty_bay/features/home/models/remark_product_model/remark_product_data.dart';
import 'package:crafty_bay/features/home/views/search_view/search_result.dart';
import 'package:crafty_bay/features/home/widgets/search_alternative.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/themes/search_bar_theme.dart';
import '../../../../core/themes/theme_switcher.dart';
import '../../state_holders/home_view_state.dart';
import '../../utils/search_strings.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    if (Get.find<ThemeSwitcher>().themeMode == ThemeMode.dark) {
      return AppSearchBarTheme.getSearchBarThemeDark(context);
    }
    return AppSearchBarTheme.getSearchBarThemeLight(context);
  }

  List<RemarkProductData> searchTerms = Get.find<HomeViewState>().searchProductList;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GetBuilder<ThemeSwitcher>(
      builder: (themeSwitcher) {
        return IconButton(
          onPressed: () {
            close(context, null);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: (themeSwitcher.themeMode == ThemeMode.light)
                ? Colors.black
                : Colors.grey,
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const SearchAlternative(
        message: SearchStrings.searchWithNameText,
        icon: CupertinoIcons.search,
      );
    }
    List<RemarkProductData> matchQuery = [];
    for (RemarkProductData product in searchTerms) {
      if (product.title!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    if (matchQuery.isEmpty) {
      return SearchAlternative(
        message: SearchStrings.noSearchResultText(query),
        icon: Icons.search_off_outlined,
      );
    }
    return SearchResult(matchQuery: matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SearchAlternative(
      message: SearchStrings.searchWithNameText,
      icon: CupertinoIcons.search,
    );
  }
}
