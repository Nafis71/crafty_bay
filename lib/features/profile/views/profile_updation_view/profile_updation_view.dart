import 'package:crafty_bay/core/services/internet_service_error.dart';
import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:crafty_bay/core/widgets/circular_loading.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/features/profile/models/profile_updation_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/state_holders/profile_state.dart';
import '../../../../core/wrappers/app_snack_bar.dart';

class ProfileUpdationView extends StatefulWidget {
  final ProfileUpdationModel profileUpdationModel;

  const ProfileUpdationView({
    super.key,
    required this.profileUpdationModel,
  });

  @override
  State<ProfileUpdationView> createState() => _ProfileUpdationViewState();
}

class _ProfileUpdationViewState extends State<ProfileUpdationView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _textEditingController = TextEditingController();
    _textEditingController.text = widget.profileUpdationModel.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: craftyAppBar(
          title: widget.profileUpdationModel.profileUpdationType,
          context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: _textEditingController,
                      keyboardType: TextInputType.multiline,
                      maxLines:
                          (widget.profileUpdationModel.profileUpdationType ==
                                  AppStrings.changeShipAddressText)
                              ? 4
                              : 1,
                      decoration: InputDecoration(
                        label: Text(
                          widget.profileUpdationModel.profileUpdationType,
                        ),
                      ),
                    ),
                    Gap(20),
                    SizedBox(
                      width: size.width * 0.9,
                      child: GetBuilder<ProfileState>(
                        builder: (profileState) {
                          if (profileState.isBusy) {
                            return Center(child: CircularLoading());
                          }
                          return ElevatedButton(
                            onPressed: () {
                              updateProfile(profileState);
                            },
                            child: Text(AppStrings.updateButtonText),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateProfile(ProfileState profileViewModel) async {
    bool status = await profileViewModel.updateProfile(
      widget.profileUpdationModel.profileUpdationType,
      _textEditingController.text.trim(),
    );
    if (status && mounted) {
      AppSnackBar.show(
        message: AppStrings.profileUpdationSuccessText,
        context: context,
        isError: false,
      );
      navigator!.pop();
      return;
    }
    if (mounted) {
      Failure failure = profileViewModel.response as Failure;
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
