import 'package:crafty_bay/features/base_navigation/view_model/base_navigation_view_model.dart';
import 'package:crafty_bay/features/base_navigation/views/tab_view.dart';
import 'package:crafty_bay/features/base_navigation/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BaseNavigationView extends StatefulWidget {
  const BaseNavigationView({super.key});

  @override
  State<BaseNavigationView> createState() => _BaseNavigationViewState();
}

class _BaseNavigationViewState extends State<BaseNavigationView> {
  bool _isFirstRouteInCurrentTab = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseNavigationViewModel>(
        builder: (baseNavigationViewModel) {
      return PopScope(
        onPopInvokedWithResult: (isPop, result) async {
          _isFirstRouteInCurrentTab = !await baseNavigationViewModel
              .navigatorKeys[baseNavigationViewModel.index]!.currentState!
              .maybePop();
          if (_isFirstRouteInCurrentTab) {
            if (baseNavigationViewModel.index != 0) {
              baseNavigationViewModel.setIndex = 0;
              return;
            } else {
              if (!isPop) {
                SystemNavigator.pop();
              }
            }
          }
        },
        canPop: false,
        child: Scaffold(
          body: TabView(
            currentIndex: baseNavigationViewModel.index,
            navigatorState: baseNavigationViewModel
                .navigatorKeys[baseNavigationViewModel.index]!,
          ),
          bottomNavigationBar: const BottomNavigation(),
        ),
      );
    });
  }
}
