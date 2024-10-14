import 'package:crafty_bay/core/state_holders/connection_state.dart';
import 'package:crafty_bay/features/base_navigation/state_holders/base_navigation_state.dart';
import 'package:crafty_bay/features/base_navigation/views/tab_view.dart';
import 'package:crafty_bay/features/base_navigation/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/wrappers/app_snack_bar.dart';

class BaseNavigationView extends StatefulWidget {
  const BaseNavigationView({super.key});

  @override
  State<BaseNavigationView> createState() => _BaseNavigationViewState();
}

class _BaseNavigationViewState extends State<BaseNavigationView> {
  bool _isFirstRouteInCurrentTab = true;
  bool _hasShownSnackBar = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseNavigationState>(builder: (baseNavigationState) {
      return PopScope(
        onPopInvokedWithResult: (isPop, result) async {
          _isFirstRouteInCurrentTab = !await baseNavigationState
              .navigatorKeys[baseNavigationState.index]!.currentState!
              .maybePop();
          if (_isFirstRouteInCurrentTab) {
            if (baseNavigationState.index != 0) {
              baseNavigationState.setIndex = 0;
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
          body: GetBuilder<NetworkState>(builder: (networkState) {
            if (networkState.hasInternet) {
              _hasShownSnackBar = false;
            } else {
              if (!_hasShownSnackBar) {
                _hasShownSnackBar = true;
                Future.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    AppSnackBar.show(
                      message: AppStrings.networkError,
                      context: context,
                      isError: true,
                      color: Colors.black,
                    );
                  }
                });
              }
            }
            return TabView(
              currentIndex: baseNavigationState.index,
              navigatorState:
                  baseNavigationState.navigatorKeys[baseNavigationState.index]!,
            );
          }),
          bottomNavigationBar: const BottomNavigation(),
        ),
      );
    });
  }
}
