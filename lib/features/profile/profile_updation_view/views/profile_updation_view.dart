import 'package:crafty_bay/core/widgets/circular_loading.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/features/profile/profile_updation_view/utils/profile_update_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../shared/state_holders/profile_state.dart';
import '../../profile_view/utils/profile_view_strings.dart';
import '../models/profile_updation_model.dart';

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
                                  ProfileViewStrings.changeShipAddressText)
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
                              ProfileUpdateHelper().initiateProfileUpdate(
                                profileUpdationType: widget
                                    .profileUpdationModel.profileUpdationType,
                                changedValue:
                                    _textEditingController.text.trim(),
                                context: context,
                                profileState: profileState,
                              );
                            },
                            child: Text(ProfileViewStrings.updateButtonText),
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

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
