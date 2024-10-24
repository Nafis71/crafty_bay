import 'dart:async';

import 'package:crafty_bay/core/utils/form_validation.dart';
import 'package:crafty_bay/core/widgets/authentication_layout.dart';
import 'package:crafty_bay/features/authentication/otp_verification_view/utils/otp_verification_strings.dart';
import 'package:crafty_bay/features/authentication/otp_verification_view/utils/otp_verification_view_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/themes/app_color.dart';
import '../../../../../core/themes/pin_code_theme.dart';
import '../../shared/state_holders/auth_state.dart';
import '../state_holders/countdown_timer.dart';

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
                  titleText: OtpVerificationStrings.otpVerificationScreenTitle,
                  descriptionText:
                      OtpVerificationStrings.otpVerificationScreenDescription,
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
                            OtpVerificationViewHelper.verifyOTP(
                              authState: Get.find<AuthState>(),
                              context: context,
                              email: widget.viewData['email'],
                              otp: _otpTEController.text,
                              futureExecution:
                                  widget.viewData['futureExecution'],
                            );
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
                                  text:
                                      OtpVerificationStrings.otpExpirationText,
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
                              OtpVerificationStrings.otpResendButtonText,
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
                      OtpVerificationViewHelper.verifyOTP(
                        authState: Get.find<AuthState>(),
                        context: context,
                        email: widget.viewData['email'],
                        otp: _otpTEController.text,
                        futureExecution: widget.viewData['futureExecution'],
                      );
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

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
