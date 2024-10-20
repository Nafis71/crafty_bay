import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../core/themes/app_color.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/form_validation.dart';
import '../state_holders/complete_profile_view_state.dart';

class CompleteProfileForm extends StatelessWidget {
  final TextEditingController nameTEController,
      mobileTEController,
      cityTEController,
      stateTEController,
      postCodeTEController,
      countryTEController,
      customerAddressTEController,
      shippingAddressTEController;
  final FocusNode mobileFocusNode,
      cityFocusNode,
      stateFocusNode,
      postCodeFocusNode,
      countryFocusNode,
      customerAddressFocusNode,
      shippingAddressFocusNode;
  final GlobalKey<FormState> formKey;

  const CompleteProfileForm(
      {super.key,
      required this.nameTEController,
      required this.mobileTEController,
      required this.cityTEController,
      required this.stateTEController,
      required this.postCodeTEController,
      required this.countryTEController,
      required this.customerAddressTEController,
      required this.shippingAddressTEController,
      required this.mobileFocusNode,
      required this.cityFocusNode,
      required this.stateFocusNode,
      required this.postCodeFocusNode,
      required this.countryFocusNode,
      required this.customerAddressFocusNode,
      required this.shippingAddressFocusNode,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameTEController,
              keyboardType: TextInputType.text,
              cursorColor: AppColor.appPrimaryColor,
              decoration: const InputDecoration(
                hintText: AppStrings.firstNameHintText,
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(mobileFocusNode);
              },
              validator: FormValidation.validateFirstName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Gap(15),
            TextFormField(
              controller: mobileTEController,
              focusNode: mobileFocusNode,
              keyboardType: TextInputType.number,
              cursorColor: AppColor.appPrimaryColor,
              decoration: const InputDecoration(
                hintText: AppStrings.mobileHintText,
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(cityFocusNode);
              },
              validator: FormValidation.validateMobile,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Gap(15),
            TextFormField(
              controller: cityTEController,
              focusNode: cityFocusNode,
              keyboardType: TextInputType.text,
              cursorColor: AppColor.appPrimaryColor,
              decoration: const InputDecoration(
                hintText: AppStrings.cityHintText,
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(stateFocusNode);
              },
              validator: FormValidation.validateCity,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Gap(15),
            TextFormField(
              controller: stateTEController,
              focusNode: stateFocusNode,
              keyboardType: TextInputType.text,
              cursorColor: AppColor.appPrimaryColor,
              decoration: const InputDecoration(
                hintText: AppStrings.stateHintText,
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(postCodeFocusNode);
              },
              validator: FormValidation.validateState,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Gap(15),
            TextFormField(
              controller: postCodeTEController,
              focusNode: postCodeFocusNode,
              keyboardType: TextInputType.number,
              cursorColor: AppColor.appPrimaryColor,
              decoration: const InputDecoration(
                hintText: AppStrings.postCodeHintText,
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(countryFocusNode);
              },
              validator: FormValidation.validatePostCode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Gap(15),
            TextFormField(
              controller: countryTEController,
              focusNode: countryFocusNode,
              keyboardType: TextInputType.text,
              cursorColor: AppColor.appPrimaryColor,
              decoration: const InputDecoration(
                hintText: AppStrings.countryHintText,
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(shippingAddressFocusNode);
              },
              validator: FormValidation.validateCountry,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Gap(15),
            TextFormField(
              controller: customerAddressTEController,
              focusNode: customerAddressFocusNode,
              keyboardType: TextInputType.multiline,
              cursorColor: AppColor.appPrimaryColor,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: AppStrings.customerAddressHintText,
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
              validator: FormValidation.validateCustomerAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            GetBuilder<CompleteProfileViewState>(
                builder: (completeProfileViewState) {
              return Row(
                children: [
                  Checkbox(
                      value: completeProfileViewState.useSameShippingAddress,
                      onChanged: (bool? value) {
                        if(value!= null && value){
                          shippingAddressTEController.text = "";
                        }
                        completeProfileViewState.toggleUseSameShippingAddress();
                      },
                      activeColor: Theme.of(context).primaryColor,
                      side: BorderSide(
                        color: Colors.grey.shade400,
                        width: 2,
                      )),
                  Text("Use as shipping address"),
                ],
              );
            }),
            Gap(15),
            GetBuilder<CompleteProfileViewState>(
                builder: (completeProfileViewState) {
              if (completeProfileViewState.useSameShippingAddress) {
                return SizedBox.shrink();
              }
              return TextFormField(
                controller: shippingAddressTEController,
                focusNode: shippingAddressFocusNode,
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
              );
            }),
          ],
        ),
      ),
    );
  }
}
