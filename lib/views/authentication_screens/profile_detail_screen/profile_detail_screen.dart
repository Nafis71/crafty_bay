import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:crafty_bay/views/widgets/authentication_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
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
        child: Center(
          child: SingleChildScrollView(
            child: AuthenticationLayout(
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
                          FocusScope.of(context)
                              .requestFocus(_lastNameFocusNode);
                        },
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
                          FocusScope.of(context)
                              .requestFocus(_mobileFocusNode);
                        },
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
                          FocusScope.of(context)
                              .requestFocus(_cityFocusNode);
                        },
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
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _shippingAddressTEController,
                        focusNode: _shippingAddressFocusNode,
                        keyboardType: TextInputType.text,
                        cursorColor: AppColor.appPrimaryColor,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: AppStrings.shippingAddressHintText,
                        ),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              deviceOrientation: deviceOrientation,
              buttonText: AppStrings.profileDetailsButtonText,
              onButtonPressed: () {},
            ),
          ),
        ),
      ),
    );
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
