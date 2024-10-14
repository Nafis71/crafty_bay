import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../utils/app_routes.dart';
import '../utils/app_strings.dart';
import 'alternative_widget.dart';

class LoginPrompt extends StatelessWidget {
  final String subtitle;
  final Function(dynamic) futureExecution;

  const LoginPrompt(
      {super.key, required this.subtitle, required this.futureExecution});

  @override
  Widget build(BuildContext context) {
    return AlternativeWidget(
      child: Column(
        children: [
          Icon(
            Icons.login_outlined,
            color: Theme.of(context).primaryColor,
            size: 45,
          ),
          const Gap(15),
          Text(
            subtitle,
          ),
          const Gap(20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: ElevatedButton(
              onPressed: () {
                navigator!.pushNamed(
                  AppRoutes.loginView,
                  arguments: (token) async {
                    futureExecution(token);
                  },
                );
              },
              child: Text(
                AppStrings.loginButtonText,
              ),
            ),
          ),
        ],
      ),
      onRefresh: () {},
    );
    ;
  }
}
