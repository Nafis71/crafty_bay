class RegEx {
  static RegExp emailRegEx = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  static RegExp digitRegEx = RegExp(r'^[0-9]+$');
  static RegExp alphabetRegEx = RegExp(r'^[a-z A-Z]+$');
  static RegExp shippingAddressRegEx = RegExp(r'^[a-zA-Z0-9 /:,-]+$');
  static RegExp mobileRegEx = RegExp(r'^(?:\+?88|0088)?01[3-9]\d{8}$');
}
