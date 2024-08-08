import 'package:crafty_bay/services/response/failure.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_routes.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:crafty_bay/features/authentication_screens/view_model/auth_view_model.dart';
import 'package:crafty_bay/features/widgets/authentication_layout.dart';
import 'package:crafty_bay/utils/form_validation.dart';
import 'package:crafty_bay/wrappers/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                _sendOTP(Get.find<AuthViewModel>());
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendOTP(AuthViewModel authViewModel)async{
    bool status = await authViewModel.sendOTP(_emailTEController.text.trim());
    if(status && mounted){
      Navigator.pushNamed(context, AppRoutes.otpVerificationScreen);
      return;
    }
    Failure failureResponse = authViewModel.response as Failure;
    if((failureResponse.statusCode == 601 || failureResponse.statusCode == 600) && mounted){
      AppSnackBar.show(message: failureResponse.errorMessage.toString(), context: context);
      return;
    }
    if(mounted){
      AppSnackBar.show(message: AppStrings.unknownError, context: context);
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
