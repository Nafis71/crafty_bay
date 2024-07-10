import 'dart:async';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/themes/pin_code_theme.dart';
import 'package:crafty_bay/views/authentication_screens/otp_verification_screen/countdown_timer.dart';
import 'package:crafty_bay/views/widgets/authentication_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_strings.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    initiateTimer();
  }

  void initiateTimer() {
    context.read<CountdownTimer>().resetTime();
    timer = Timer.periodic(const Duration(seconds: 1), (countdown) {
      if (countdown.tick > 120) {
        countdown.cancel();
        return;
      }
      context.read<CountdownTimer>().decreaseTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        horizontal: (deviceOrientation == Orientation.portrait) ? 40 : 180, vertical: 10),
                    child: PinCodeTextField(
                        keyboardType: TextInputType.number,
                        pinTheme: PinCodeTheme.getPinTheme(context),
                        onCompleted: (pin) {},
                        appContext: context,
                        length: 4),
                  ),
                  bottomWidget: Consumer<CountdownTimer>(
                    builder: (_, viewModel, __) {
                      return Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: AppStrings.otpExpirationText,style:Theme.of(context).textTheme.titleMedium),
                                TextSpan(
                                  text: " ${viewModel.timeLeft}s",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.appPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(10),
                          const Text(AppStrings.otpResendButtonText),
                        ],
                      );
                    },
                  ),
                  deviceOrientation: deviceOrientation,
                  onButtonPressed: () {
                    Navigator.pushNamed(context, AppRoutes.profileDetailScreen);
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
