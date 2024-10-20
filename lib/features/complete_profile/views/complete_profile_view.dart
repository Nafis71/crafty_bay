import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:crafty_bay/core/widgets/authentication_layout.dart';
import 'package:crafty_bay/features/complete_profile/widgets/complete_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/internet_service_error.dart';
import '../../../core/state_holders/profile_state.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _shippingAddressTEController =
      TextEditingController();
  final TextEditingController _postCodeTEController = TextEditingController();
  final TextEditingController _stateTEController = TextEditingController();
  final TextEditingController _countryTEController = TextEditingController();
  final TextEditingController _faxTEController = TextEditingController();
  final TextEditingController _customerAddressTEController =
      TextEditingController();
  final TextEditingController _shippingCityTEController =
      TextEditingController();
  final TextEditingController _shippingPhoneTEController =
      TextEditingController();
  final TextEditingController _shippingStateTEController =
      TextEditingController();
  final TextEditingController _shippingPostCodeTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _shippingAddressFocusNode = FocusNode();
  final FocusNode _postCodeFocusNode = FocusNode();
  final FocusNode _stateFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();
  final FocusNode _faxTEFocusNode = FocusNode();
  final FocusNode _customerAddressFocusNode = FocusNode();
  final FocusNode _shippingCityFocusNode = FocusNode();
  final FocusNode _shippingPhoneFocusNode = FocusNode();
  final FocusNode _shippingStateFocusNode = FocusNode();
  final FocusNode _shippingPostCodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 20,
      ),
      body: SingleChildScrollView(
        child: AuthenticationLayout(
          isProfileDetailView: true,
          titleText: AppStrings.profileDetailsScreenTitle,
          descriptionText: AppStrings.profileDetailsScreenDescription,
          formWidget: CompleteProfileForm(
            nameTEController: _nameTEController,
            mobileTEController: _mobileTEController,
            cityTEController: _cityTEController,
            stateTEController: _stateTEController,
            postCodeTEController: _postCodeTEController,
            countryTEController: _countryTEController,
            customerAddressTEController: _customerAddressTEController,
            shippingAddressTEController: _shippingAddressTEController,
            mobileFocusNode: _mobileFocusNode,
            cityFocusNode: _cityFocusNode,
            stateFocusNode: _stateFocusNode,
            postCodeFocusNode: _postCodeFocusNode,
            countryFocusNode: _countryFocusNode,
            customerAddressFocusNode: _customerAddressFocusNode,
            shippingAddressFocusNode: _shippingAddressFocusNode,
            formKey: _formKey,
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
    );
  }

  Future<void> createProfile(ProfileState profileState) async {
    bool status = await profileState.createProfile(
      name: _nameTEController.text.trim(),
      mobile: _mobileTEController.text.trim(),
      city: _cityTEController.text.trim(),
      shippingAddress: _shippingAddressTEController.text.trim(),
      postCode: _postCodeTEController.text.trim(),
      customerAddress: _customerAddressTEController.text.trim(),
      state: _stateTEController.text.trim(),
      country: _countryTEController.text.trim(),
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
    _nameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _shippingAddressTEController.dispose();
    _postCodeTEController.dispose();
    _mobileFocusNode.dispose();
    _cityFocusNode.dispose();
    _shippingAddressFocusNode.dispose();
    _postCodeFocusNode.dispose();
    _stateTEController.dispose();
    _stateFocusNode.dispose();
    _faxTEController.dispose();
    _faxTEFocusNode.dispose();
    _countryTEController.dispose();
    _countryFocusNode.dispose();
    _customerAddressTEController.dispose();
    _customerAddressFocusNode.dispose();
    _shippingCityTEController.dispose();
    _shippingCityFocusNode.dispose();
    _shippingPhoneFocusNode.dispose();
    _shippingPhoneTEController.dispose();
    _shippingStateTEController.dispose();
    _shippingStateFocusNode.dispose();
    _shippingPostCodeTEController.dispose();
    _shippingPostCodeFocusNode.dispose();
    super.dispose();
  }
}
