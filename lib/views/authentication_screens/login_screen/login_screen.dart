import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_routes.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:crafty_bay/views/widgets/authentication_layout.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: AuthenticationLayout(
              titleText: AppStrings.loginScreenTitle,
              descriptionText: AppStrings.loginScreenDescription,
              formWidget: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: AppColor.appPrimaryColor,
                        decoration: const InputDecoration(
                            hintText: AppStrings.emailTextFieldHintText),
                      ),
                    ],
                  ),
                ),
              ),
              deviceOrientation: deviceOrientation,
              onButtonPressed: () {
                Navigator.pushNamed(context, AppRoutes.otpVerificationScreen);
              },
            ),
          ),
        ),
      ),
    );
  }
}
