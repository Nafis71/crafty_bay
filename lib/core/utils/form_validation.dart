import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:crafty_bay/core/utils/reg_ex.dart';

class FormValidation {
  static String? validateEmail(String? emailAddress) {
    if (emailAddress == null || emailAddress.isEmpty) {
      return AppStrings.emptyEmailAddress;
    }
    if (!RegEx.emailRegEx.hasMatch(emailAddress)) {
      return AppStrings.invalidEmailAddress;
    }
    return null;
  }

  static String? validateOTP(String? otp) {
    if (otp == null || otp.isEmpty) {
      return AppStrings.emptyOTP;
    }
    if (!RegEx.digitRegEx.hasMatch(otp)) {
      return AppStrings.invalidOTPErrorText;
    }
    return null;
  }

  static String? validateFirstName(String? firstName) {
    if (firstName == null || firstName.isEmpty) {
      return AppStrings.emptyFirstName;
    }
    if (!RegEx.alphabetRegEx.hasMatch(firstName)) {
      return AppStrings.invalidFirstNameText;
    }
    return null;
  }

  static String? validateReview(String? review) {
    if (review == null || review.isEmpty) {
      return AppStrings.emptyReviewText;
    }
    return null;
  }

  static String? validateLastName(String? lastName) {
    if (lastName == null || lastName.isEmpty) {
      return AppStrings.emptyLastName;
    }
    if (!RegEx.alphabetRegEx.hasMatch(lastName)) {
      return AppStrings.invalidLastNameText;
    }
    return null;
  }

  static String? validateMobile(String? mobile) {
    if (mobile == null || mobile.isEmpty) {
      return AppStrings.emptyMobile;
    }
    if (!RegEx.mobileRegEx.hasMatch(mobile)) {
      return AppStrings.invalidMobileText;
    }
    return null;
  }

  static String? validateCity(String? city) {
    if (city == null || city.isEmpty) {
      return AppStrings.emptyCity;
    }
    if (!RegEx.alphabetRegEx.hasMatch(city)) {
      return AppStrings.invalidCityText;
    }
    return null;
  }

  static String? validatePostCode(String? postCode) {
    if (postCode == null || postCode.isEmpty) {
      return AppStrings.emptyPostCode;
    }
    if (!RegEx.digitRegEx.hasMatch(postCode)) {
      return AppStrings.invalidPostCode;
    }
    return null;
  }

  static String? validateShippingAddress(String? shippingAddress) {
    if (shippingAddress == null || shippingAddress.isEmpty) {
      return AppStrings.emptyShippingAddress;
    }
    if (!RegEx.shippingAddressRegEx.hasMatch(shippingAddress)) {
      return AppStrings.invalidShippingAddress;
    }
    return null;
  }
}
