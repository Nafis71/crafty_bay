import 'package:crafty_bay/utils/app_strings.dart';
import 'package:crafty_bay/utils/reg_ex.dart';

class FormValidation{
  static String? validateEmail(String? emailAddress){
    if(emailAddress == null || emailAddress.isEmpty){
      return AppStrings.emptyEmailAddress;
    }
    if(!RegEx.emailRegEx.hasMatch(emailAddress)){
      return AppStrings.invalidEmailAddress;
    }
    return null;
  }
}