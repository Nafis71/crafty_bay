import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:crafty_bay/core/utils/form_validation.dart';
import 'package:crafty_bay/core/widgets/authentication_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/internet_service_error.dart';
import '../../../../core/state_holders/profile_state.dart';
import '../../../../core/themes/app_color.dart';

class ProfileDetailView extends StatefulWidget {
  const ProfileDetailView({super.key});

  @override
  State<ProfileDetailView> createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<ProfileDetailView> {
  late final TextEditingController _firstNameTEController;
  late final TextEditingController _lastNameTEController;
  late final TextEditingController _mobileTEController;
  late final TextEditingController _cityTEController;
  late final TextEditingController _shippingAddressTEController;
  late final TextEditingController _postCodeTEController;
  late final GlobalKey<FormState> _formKey;

  late final FocusNode _lastNameFocusNode;
  late final FocusNode _mobileFocusNode;
  late final FocusNode _cityFocusNode;
  late final FocusNode _shippingAddressFocusNode;
  late final FocusNode _postCodeFocusNode;

  @override
  void initState() {
    _firstNameTEController = TextEditingController();
    _lastNameTEController = TextEditingController();
    _mobileTEController = TextEditingController();
    _cityTEController = TextEditingController();
    _shippingAddressTEController = TextEditingController();
    _postCodeTEController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _lastNameFocusNode = FocusNode();
    _mobileFocusNode = FocusNode();
    _cityFocusNode = FocusNode();
    _shippingAddressFocusNode = FocusNode();
    _postCodeFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: AuthenticationLayout(
            isProfileDetailView: true,
            titleText: AppStrings.profileDetailsScreenTitle,
            descriptionText: AppStrings.profileDetailsScreenDescription,
            formWidget: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameTEController,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColor.appPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: AppStrings.firstNameHintText,
                      ),
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_lastNameFocusNode);
                      },
                      validator: FormValidation.validateFirstName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _lastNameTEController,
                      focusNode: _lastNameFocusNode,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColor.appPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: AppStrings.lastNameHintText,
                      ),
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_mobileFocusNode);
                      },
                      validator: FormValidation.validateLastName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _mobileTEController,
                      focusNode: _mobileFocusNode,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.appPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: AppStrings.mobileHintText,
                      ),
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_cityFocusNode);
                      },
                      validator: FormValidation.validateMobile,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _cityTEController,
                      focusNode: _cityFocusNode,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColor.appPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: AppStrings.cityHintText,
                      ),
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_postCodeFocusNode);
                      },
                      validator: FormValidation.validateCity,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _postCodeTEController,
                      focusNode: _postCodeFocusNode,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.appPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: AppStrings.postCodeHintText,
                      ),
                      onFieldSubmitted: (value) {
                        FocusScope.of(context)
                            .requestFocus(_shippingAddressFocusNode);
                      },
                      validator: FormValidation.validatePostCode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _shippingAddressTEController,
                      focusNode: _shippingAddressFocusNode,
                      keyboardType: TextInputType.multiline,
                      cursorColor: AppColor.appPrimaryColor,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: AppStrings.shippingAddressHintText,
                      ),
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      validator: FormValidation.validateShippingAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ],
                ),
              ),
            ),
            deviceOrientation: deviceOrientation,
            buttonText: AppStrings.profileDetailsButtonText,
            onButtonPressed: () {
              if (_formKey.currentState!.validate()) {
                createProfile(Get.find<ProfileState>());
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> createProfile(ProfileState profileState) async {
    bool status = await profileState.createProfile(
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      mobile: _mobileTEController.text.trim(),
      city: _cityTEController.text.trim(),
      shippingAddress: _shippingAddressTEController.text.trim(),
      postCode: _postCodeTEController.text.trim(),
    );
    if (!status && mounted) {
      Failure failure = profileState.response as Failure;
      if (mounted) {
        InternetServiceError.showErrorSnackBar(
          failure: failure,
          context: context,
        );
      }
      return;
    }
    if (mounted) {
      navigator!.pop();
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _shippingAddressTEController.dispose();
    _postCodeTEController.dispose();
    _lastNameFocusNode.dispose();
    _mobileFocusNode.dispose();
    _cityFocusNode.dispose();
    _shippingAddressFocusNode.dispose();
    _postCodeFocusNode.dispose();
    super.dispose();
  }
}
