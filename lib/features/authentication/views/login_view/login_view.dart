import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/widgets/authentication_layout.dart';
import 'package:crafty_bay/features/authentication/view_model/auth_view_model.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_routes.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:crafty_bay/utils/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/internet_service_error.dart';

class LoginView extends StatefulWidget {
  final Function(dynamic) futureExecution;

  const LoginView({super.key, required this.futureExecution});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailTEController;

  @override
  void initState() {
    _emailTEController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(),
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
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: AppColor.appPrimaryColor,
                        decoration: const InputDecoration(
                          hintText: AppStrings.emailTextFieldHintText,
                        ),
                        validator: FormValidation.validateEmail,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ],
                  ),
                ),
              ),
              deviceOrientation: deviceOrientation,
              onButtonPressed: () {
                if (_formKey.currentState!.validate()) {
                  _sendOTP(Get.find<AuthViewModel>());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendOTP(AuthViewModel authViewModel) async {
    bool status = await authViewModel.sendOTP(_emailTEController.text.trim());
    if (status && mounted) {
      Map<String, dynamic> viewData = {
        "email": _emailTEController.text.trim(),
        "futureExecution": widget.futureExecution
      };
      navigator!.pushReplacementNamed(
        AppRoutes.otpVerificationView,
        arguments: viewData,
      );
      return;
    }
    Failure failure = authViewModel.response as Failure;
    if (mounted) {
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
