import 'package:crafty_bay/core/view_model/profile_view_model.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/features/profile/models/profile_updation_model.dart';
import 'package:crafty_bay/features/profile/widgets/profile_options.dart';
import 'package:crafty_bay/features/profile/widgets/profile_overview.dart';
import 'package:crafty_bay/features/profile/widgets/theme_switch.dart';
import 'package:crafty_bay/themes/theme_switcher.dart';
import 'package:crafty_bay/utils/app_routes.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar:
          craftyAppBar(title: AppStrings.profileScreenTitle, context: context),
      body: GetBuilder<ProfileViewModel>(
        builder: (profileViewModel) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(30),
                ProfileOverview(profileViewModel: profileViewModel),
                Gap(30),
                ProfileOptions(
                  optionLeadingWidget: Text(AppStrings.changeNameText),
                  optionTrailingWidget: IconButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      navigator!.pushNamed(
                        AppRoutes.profileUpdationView,
                        arguments: ProfileUpdationModel(
                          profileUpdationType: AppStrings.changeNameText,
                          value: profileViewModel.userModel.cusName.toString(),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                ),
                Gap(5),
                ProfileOptions(
                  optionLeadingWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.changeShipAddressText,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          profileViewModel.userModel.shipAdd.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  optionTrailingWidget: IconButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      navigator!.pushNamed(
                        AppRoutes.profileUpdationView,
                        arguments: ProfileUpdationModel(
                          profileUpdationType: AppStrings.changeShipAddressText,
                          value: profileViewModel.userModel.shipAdd.toString(),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                ),
                Gap(5),
                ProfileOptions(
                  optionLeadingWidget: Text(AppStrings.changeContactNumberText),
                  optionTrailingWidget: IconButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      navigator!.pushNamed(
                        AppRoutes.profileUpdationView,
                        arguments: ProfileUpdationModel(
                          profileUpdationType:
                              AppStrings.changeContactNumberText,
                          value: profileViewModel.userModel.cusPhone.toString(),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                ),
                Gap(5),
                GetBuilder<ThemeSwitcher>(
                  builder: (themeSwitcher) {
                    return ProfileOptions(
                        optionLeadingWidget: Text(AppStrings.darkModeText),
                        optionTrailingWidget: ThemeSwitch(themeSwitcher: themeSwitcher,));
                  }
                ),
                Gap(20),
                SizedBox(
                  width: size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      profileViewModel.logout();
                      navigator!.pop();
                    },
                    child: Text(AppStrings.logoutButtonText),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
