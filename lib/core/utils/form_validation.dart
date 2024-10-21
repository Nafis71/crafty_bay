import 'package:crafty_bay/core/utils/reg_ex.dart';
import 'package:crafty_bay/features/complete_profile/utils/complete_profile_strings.dart';
import 'package:crafty_bay/features/product_review/add_review_view/utils/add_review_view_strings.dart';

import '../../features/authentication/login_view/utils/login_view_strings.dart';
import '../../features/authentication/otp_verification_view/utils/otp_verification_strings.dart';

class FormValidation {
  static String? validateEmail(String? emailAddress) {
    if (emailAddress == null || emailAddress.isEmpty) {
      return LoginViewStrings.emptyEmailAddress;
    }
    if (!RegEx.emailRegEx.hasMatch(emailAddress)) {
      return LoginViewStrings.invalidEmailAddress;
    }
    return null;
  }

  static String? validateOTP(String? otp) {
    if (otp == null || otp.isEmpty) {
      return OtpVerificationStrings.emptyOTP;
    }
    if (!RegEx.digitRegEx.hasMatch(otp)) {
      return OtpVerificationStrings.invalidOTPErrorText;
    }
    return null;
  }

  static String? validateFirstName(String? firstName) {
    if (firstName == null || firstName.isEmpty) {
      return CompleteProfileStrings.emptyFirstName;
    }
    if (!RegEx.alphabetRegEx.hasMatch(firstName)) {
      return CompleteProfileStrings.invalidFirstNameText;
    }
    return null;
  }

  static String? validateReview(String? review) {
    if (review == null || review.isEmpty) {
      return AddReviewViewStrings.emptyReviewText;
    }
    return null;
  }

  static String? validateLastName(String? lastName) {
    if (lastName == null || lastName.isEmpty) {
      return CompleteProfileStrings.emptyLastName;
    }
    if (!RegEx.alphabetRegEx.hasMatch(lastName)) {
      return CompleteProfileStrings.invalidLastNameText;
    }
    return null;
  }

  static String? validateMobile(String? mobile) {
    if (mobile == null || mobile.isEmpty) {
      return CompleteProfileStrings.emptyMobile;
    }
    if (!RegEx.mobileRegEx.hasMatch(mobile)) {
      return CompleteProfileStrings.invalidMobileText;
    }
    return null;
  }

  static String? validateCity(String? city) {
    if (city == null || city.isEmpty) {
      return CompleteProfileStrings.emptyCity;
    }
    if (!RegEx.alphabetRegEx.hasMatch(city)) {
      return CompleteProfileStrings.invalidCityText;
    }
    return null;
  }

  static String? validateState(String? state) {
    if (state == null || state.isEmpty) {
      return CompleteProfileStrings.emptyState;
    }
    if (!RegEx.alphabetRegEx.hasMatch(state)) {
      return CompleteProfileStrings.invalidState;
    }
    return null;
  }

  static String? validateCountry(String? country) {
    if (country == null || country.isEmpty) {
      return CompleteProfileStrings.emptyCountry;
    }
    if (!RegEx.alphabetRegEx.hasMatch(country)) {
      return CompleteProfileStrings.invalidCountry;
    }
    return null;
  }

  static String? validatePostCode(String? postCode) {
    if (postCode == null || postCode.isEmpty) {
      return CompleteProfileStrings.emptyPostCode;
    }
    if (!RegEx.digitRegEx.hasMatch(postCode)) {
      return CompleteProfileStrings.invalidPostCode;
    }
    return null;
  }

  static String? validateShippingAddress(String? shippingAddress) {
    if (shippingAddress == null || shippingAddress.isEmpty) {
      return CompleteProfileStrings.emptyShippingAddress;
    }
    if (!RegEx.shippingAddressRegEx.hasMatch(shippingAddress)) {
      return CompleteProfileStrings.invalidShippingAddress;
    }
    return null;
  }

  static String? validateCustomerAddress(String? customerAddress) {
    if (customerAddress == null || customerAddress.isEmpty) {
      return CompleteProfileStrings.emptyCustomerAddress;
    }
    if (!RegEx.shippingAddressRegEx.hasMatch(customerAddress)) {
      return CompleteProfileStrings.invalidCustomerAddress;
    }
    return null;
  }
}
