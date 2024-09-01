import 'dart:async';

import 'package:crafty_bay/common/services/internet_service_error.dart';
import 'package:crafty_bay/common/services/response/failure.dart';
import 'package:crafty_bay/common/widgets/authentication_layout.dart';
import 'package:crafty_bay/features/authentication/view_model/auth_view_model.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/themes/pin_code_theme.dart';
import 'package:crafty_bay/utils/form_validation.dart';
import 'package:crafty_bay/wrappers/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../utils/app_routes.dart';
import '../../../../utils/app_strings.dart';
import 'countdown_timer.dart';

class OtpVerificationView extends StatefulWidget {
  final Map<String, dynamic> viewData;

  const OtpVerificationView({super.key, required this.viewData});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  late Timer timer;
  late final TextEditingController _otpTEController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _otpTEController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
    initiateTimer();
  }

  void initiateTimer() {
    Get.find<CountdownTimer>().resetTime();
    timer = Timer.periodic(const Duration(seconds: 1), (countdown) {
      if (countdown.tick > 120) {
        countdown.cancel();
        return;
      }
      Get.find<CountdownTimer>().decreaseTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthenticationLayout(
                  titleText: AppStrings.otpVerificationScreenTitle,
                  descriptionText: AppStrings.otpVerificationScreenDescription,
                  formWidget: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: (deviceOrientation == Orientation.portrait)
                            ? 40
                            : 180,
                        vertical: 10),
                    child: Form(
                      key: _formKey,
                      child: PinCodeTextField(
                        controller: _otpTEController,
                        keyboardType: TextInputType.number,
                        pinTheme: PinCodeTheme.getPinTheme(context),
                        onCompleted: (pin) {
                          if (_formKey.currentState!.validate()) {
                            _verifyOTP(Get.find<AuthViewModel>());
                          }
                        },
                        cursorColor: AppColor.appPrimaryColor,
                        appContext: context,
                        validator: FormValidation.validateOTP,
                        length: 4,
                      ),
                    ),
                  ),
                  bottomWidget: GetBuilder<CountdownTimer>(
                    builder: (timer) {
                      return Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.otpExpirationText,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                TextSpan(
                                  text: " ${timer.timeLeft}s",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: AppColor.appPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(10),
                          InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (timer.timeLeft != 0) {
                                return;
                              }
                              initiateTimer();
                              Get.find<AuthViewModel>().sendOTP(
                                widget.viewData['email'],
                                isResending: true,
                              );
                            },
                            child: Text(
                              AppStrings.otpResendButtonText,
                              style: TextStyle(
                                color: (timer.timeLeft == 0)
                                    ? AppColor.appPrimaryColor
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  deviceOrientation: deviceOrientation,
                  onButtonPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _verifyOTP(Get.find<AuthViewModel>());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _verifyOTP(AuthViewModel authViewModel) async {
    if (Get.find<CountdownTimer>().timeLeft == 0) {
      AppSnackBar.show(
          message: AppStrings.invalidOTP, context: context, isError: true);
      return;
    }
    bool status = await authViewModel.verifyOTP(
        widget.viewData['email'], _otpTEController.text,widget.viewData['futureExecution']);
    if (status && mounted && !authViewModel.hasUserData) {
      navigator!.pushReplacementNamed(AppRoutes.profileDetailView);
      return;
    }
    if (status && mounted && authViewModel.hasUserData) {
      navigator!.pop();
      return;
    }
    Failure failure = authViewModel.response as Failure;
    if (!status &&
        mounted &&
        (failure.statusCode != 600 ||
            failure.statusCode != 601 ||
            failure.statusCode != 500)) {
      AppSnackBar.show(
          message: AppStrings.invalidOTP, context: context, isError: true);
      return;
    }
    if (mounted) {
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
