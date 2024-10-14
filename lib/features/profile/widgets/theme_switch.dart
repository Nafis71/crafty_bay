import 'package:flutter/material.dart';

import '../../../core/themes/theme_switcher.dart';

class ThemeSwitch extends StatelessWidget {
  final ThemeSwitcher themeSwitcher;

  const ThemeSwitch({super.key, required this.themeSwitcher});

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Theme.of(context).primaryColor,
      value: (themeSwitcher.themeMode == ThemeMode.dark) ? true : false,
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          return Colors.grey.shade100;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return Theme.of(context).primaryColor.withOpacity(0.1);
          }
          return Colors.grey.shade100;
        },
      ),
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          return Theme.of(context).primaryColor;
        },
      ),
      thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return const Icon(
              Icons.nightlight_round,
              color: Colors.white,
            );
          }
          return const Icon(Icons.wb_sunny_rounded);
        },
      ),
      onChanged: (value) {
        if (value) {
          themeSwitcher.setThemeMode = ThemeMode.dark;
        } else {
          themeSwitcher.setThemeMode = ThemeMode.light;
        }
      },
    );
  }
}
