import 'dart:async';

import 'package:crafty_bay/core/services/internet_service_error.dart';
import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/utils/form_validation.dart';
import 'package:crafty_bay/core/widgets/authentication_layout.dart';
import 'package:crafty_bay/features/authentication/state_holders/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/pin_code_theme.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/wrappers/app_snack_bar.dart';
import 'state_holders/countdown_timer.dart';

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
    Get.find<CountdownTimerState>().resetTime();
    timer = Timer.periodic(const Duration(seconds: 1), (countdown) {
      if (countdown.tick > 120) {
        countdown.cancel();
        return;
      }
      Get.find<CountdownTimerState>().decreaseTime();
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
                      horizontal:
                          (deviceOrientation == Orientation.portrait) ? 0 : 180,
                      vertical: 10,
                    ),
                    child: Form(
                      key: _formKey,
                      child: PinCodeTextField(
                        controller: _otpTEController,
                        keyboardType: TextInputType.number,
                        pinTheme: PinCodeTheme.getPinTheme(context),
                        onCompleted: (pin) {
                          if (_formKey.currentState!.validate()) {
                            _verifyOTP(Get.find<AuthState>());
                          }
                        },
                        cursorColor: AppColor.appPrimaryColor,
                        appContext: context,
                        validator: FormValidation.validateOTP,
                        length: 6,
                      ),
                    ),
                  ),
                  bottomWidget: GetBuilder<CountdownTimerState>(
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
                              Get.find<AuthState>().sendOTP(
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
                      _verifyOTP(Get.find<AuthState>());
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

  Future<void> _verifyOTP(AuthState authState) async {
    if (Get.find<CountdownTimerState>().timeLeft == 0) {
      AppSnackBar.show(
          message: AppStrings.invalidOTP, context: context, isError: true);
      return;
    }
    bool status = await authState.verifyOTP(widget.viewData['email'],
        _otpTEController.text, widget.viewData['futureExecution']);
    if (status && mounted && !authState.hasUserData) {
      navigator!.pushReplacementNamed(AppRoutes.profileDetailView);
      return;
    }
    if (status && mounted && authState.hasUserData) {
      navigator!.pop();
      return;
    }
    Failure failure = authState.response as Failure;
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
