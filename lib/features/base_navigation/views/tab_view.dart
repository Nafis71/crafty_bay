import 'package:crafty_bay/features/cart/views/cart_view.dart';
import 'package:crafty_bay/features/category/views/category_view/category_view.dart';
import 'package:crafty_bay/features/home/views/home_view/home_view.dart';
import 'package:crafty_bay/features/wish_list/views/wish_list_view.dart';
import 'package:flutter/material.dart';

class TabView extends StatelessWidget {
  final int currentIndex;
  final GlobalKey<NavigatorState> navigatorState;

  const TabView({
    super.key,
    required this.currentIndex,
    required this.navigatorState,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorState,
      onGenerateRoute: (routeSettings) {
        if (currentIndex == 0) {
          return MaterialPageRoute(builder: (context) => const HomeView());
        } else if (currentIndex == 1) {
          return MaterialPageRoute(builder: (context) => const CategoryView());
        } else if (currentIndex == 2) {
          return MaterialPageRoute(builder: (context) => const CartView());
        }
        return MaterialPageRoute(builder: (context) => const WishListView());
      },
    );
  }
}
