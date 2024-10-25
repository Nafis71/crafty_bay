import 'package:crafty_bay/core/widgets/authentication_layout.dart';
import 'package:crafty_bay/features/complete_profile/utils/complete_profile_view_helper.dart';
import 'package:crafty_bay/features/complete_profile/widgets/complete_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profile/shared/state_holders/profile_state.dart';
import '../utils/complete_profile_strings.dart';

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
  final TextEditingController _customerAddressTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _shippingAddressFocusNode = FocusNode();
  final FocusNode _postCodeFocusNode = FocusNode();
  final FocusNode _stateFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();
  final FocusNode _customerAddressFocusNode = FocusNode();

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
          titleText: CompleteProfileStrings.profileDetailsScreenTitle,
          descriptionText:
              CompleteProfileStrings.profileDetailsScreenDescription,
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
          buttonText: CompleteProfileStrings.profileDetailsButtonText,
          onButtonPressed: () {
            if (_formKey.currentState!.validate()) {
              CompleteProfileViewHelper.createProfile(
                profileState: Get.find<ProfileState>(),
                name: _nameTEController.text.trim(),
                mobile: _mobileTEController.text.trim(),
                city: _cityTEController.text.trim(),
                shippingAddress: _shippingAddressTEController.text.trim(),
                postCode: _postCodeTEController.text.trim(),
                customerAddress: _customerAddressTEController.text.trim(),
                state: _stateTEController.text.trim(),
                country: _countryTEController.text.trim(),
                context: context,
              );
            }
          },
        ),
      ),
    );
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
    _countryTEController.dispose();
    _countryFocusNode.dispose();
    _customerAddressTEController.dispose();
    _customerAddressFocusNode.dispose();
    super.dispose();
  }
}
