import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/services/response/success.dart';
import 'package:crafty_bay/core/utils/app_routes.dart';
import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:crafty_bay/core/utils/form_validation.dart';
import 'package:crafty_bay/core/widgets/authentication_layout.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/core/wrappers/app_snack_bar.dart';
import 'package:crafty_bay/features/authentication/state_holders/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/internet_service_error.dart';
import '../../../../core/themes/app_color.dart';

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
      appBar: craftyAppBar(title: "", context: context),
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
                  _sendOTP(Get.find<AuthState>());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendOTP(AuthState authState) async {
    bool status = await authState.sendOTP(_emailTEController.text.trim());
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
    if (!status && mounted && authState.response is Success) {
      AppSnackBar.show(
        message: AppStrings.otpSendError,
        context: context,
        isError: true,
      );
    }
    Failure failure = authState.response as Failure;
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
