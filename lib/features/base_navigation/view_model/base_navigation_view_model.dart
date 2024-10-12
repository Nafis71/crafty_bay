import 'package:crafty_bay/features/Home/views/home_view/home_view.dart';
import 'package:crafty_bay/features/cart/views/cart_view.dart';
import 'package:crafty_bay/features/category/views/category_view/category_view.dart';
import 'package:crafty_bay/features/wish_list/views/wish_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseNavigationState extends GetxController {
  int _index = 0;
  final List<Widget> _views = [
    const HomeView(),
    const CategoryView(),
    const CartView(),
    const WishListView(),
  ];
  final Map<int, GlobalKey<NavigatorState>> _navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
  };

  int get index => _index;

  List<Widget> get views => _views;

  Map<int, GlobalKey<NavigatorState>> get navigatorKeys => _navigatorKeys;

  set setIndex(int index) {
    _index = index;
    update();
  }
}
