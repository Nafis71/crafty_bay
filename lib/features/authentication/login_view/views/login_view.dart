import 'package:crafty_bay/core/utils/form_validation.dart';
import 'package:crafty_bay/core/widgets/authentication_layout.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/features/authentication/login_view/utils/login_view_helper.dart';
import 'package:crafty_bay/features/authentication/login_view/utils/login_view_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/themes/app_color.dart';
import '../../shared/state_holders/auth_state.dart';

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
              titleText: LoginViewStrings.loginScreenTitle,
              descriptionText: LoginViewStrings.loginScreenDescription,
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
                          hintText: LoginViewStrings.emailTextFieldHintText,
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
                  LoginViewHelper.sendOTP(
                    authState: Get.find<AuthState>(),
                    email: _emailTEController.text,
                    context: context,
                    futureExecution: widget.futureExecution,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
