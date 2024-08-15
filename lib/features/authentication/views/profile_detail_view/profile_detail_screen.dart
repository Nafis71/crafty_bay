import 'package:crafty_bay/services/response/failure.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_routes.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:crafty_bay/utils/form_validation.dart';
import 'package:crafty_bay/view_models/profile_view_model.dart';
import 'package:crafty_bay/widgets/authentication_layout.dart';
import 'package:crafty_bay/wrappers/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  late final GlobalKey<FormState> _formKey;

  late final FocusNode _lastNameFocusNode;
  late final FocusNode _mobileFocusNode;
  late final FocusNode _cityFocusNode;
  late final FocusNode _shippingAddressFocusNode;

  @override
  void initState() {
    _firstNameTEController = TextEditingController();
    _lastNameTEController = TextEditingController();
    _mobileTEController = TextEditingController();
    _cityTEController = TextEditingController();
    _shippingAddressTEController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _lastNameFocusNode = FocusNode();
    _mobileFocusNode = FocusNode();
    _cityFocusNode = FocusNode();
    _shippingAddressFocusNode = FocusNode();
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
                        FocusScope.of(context)
                            .requestFocus(_shippingAddressFocusNode);
                      },
                      validator: FormValidation.validateCity,
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
                createProfile(Get.find<ProfileViewModel>());
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> createProfile(ProfileViewModel profileViewModel) async {
    bool status = await profileViewModel.createProfile(
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      mobile: _mobileTEController.text.trim(),
      city: _cityTEController.text.trim(),
      shippingAddress: _shippingAddressTEController.text.trim(),
    );
    if (!status && mounted) {
      Failure failure = profileViewModel.response as Failure;
      if (failure.statusCode == 600 || failure.statusCode == 601) {
        AppSnackBar.show(
            message: failure.errorMessage.toString(),
            context: context,
            isError: true);
        return;
      }
      AppSnackBar.show(
          message: AppStrings.createProfileFailure,
          context: context,
          isError: true);
      return;
    }
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.baseNavigationView, (route) => false);
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _shippingAddressTEController.dispose();
    _lastNameFocusNode.dispose();
    _mobileFocusNode.dispose();
    _cityFocusNode.dispose();
    _shippingAddressFocusNode.dispose();
    super.dispose();
  }
}
