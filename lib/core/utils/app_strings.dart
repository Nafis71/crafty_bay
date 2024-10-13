class AppStrings {
  //network errors
  static const String unknownError = "Something went wrong, please try again.";
  static const String networkError =
      "Network Error, Check your internet connection.";
  static const String internalServerError =
      "Internal Server Error, please try again later.";

  //core
  static const String loginButtonText = "Login Now";

  //login Screen
  static const String appVersion = "Version 1.0";
  static const String loginScreenTitle = "Welcome Back";
  static const String loginScreenDescription =
      "Please Enter Your Email Address";
  static const String emailTextFieldHintText = "Email Address";
  static const String loginScreenButtonText = "Next";
  static const String invalidEmailAddress = "Invalid Email Address";
  static const String emptyEmailAddress = "Email address is required";
  static const String otpSendError = "Failed to send OTP, try again later";

  //otp screen
  static const String otpVerificationScreenTitle = "Enter OTP Code";
  static const String otpVerificationScreenDescription =
      "A 6 digit OTP code has been sent";
  static const String otpExpirationText = "This code will expire in";
  static const String otpResendButtonText = "Resend Code";
  static const String invalidOTP = "Invalid OTP, please try again!";
  static const String invalidOTPErrorText = "Invalid OTP";
  static const String emptyOTP = "A 4 digit OTP is required";

  //profile details screen
  static const String profileDetailsScreenTitle = "Complete Profile";
  static const String profileDetailsScreenDescription =
      "Get started with us with your details";
  static const String firstNameHintText = "First Name";
  static const String emptyFirstName = "First name is required";
  static const String lastNameHintText = "Last Name";
  static const String emptyLastName = "Last name is required";
  static const String mobileHintText = "Mobile";
  static const String emptyMobile = "Mobile number is required";
  static const String cityHintText = "City";
  static const String emptyCity = "City is required";
  static const String postCodeHintText = "Post Code";
  static const String emptyPostCode = "Post Code is required";
  static const String shippingAddressHintText = "Shipping Address";
  static const String emptyShippingAddress = "Shipping address is required";
  static const String invalidFirstNameText = "Invalid First Name";
  static const String invalidLastNameText = "Invalid Last Name";
  static const String invalidMobileText = "Invalid Mobile Number";
  static const String invalidCityText = "Invalid City Name";
  static const String invalidShippingAddress = "Invalid Shipping Address";
  static const String invalidPostCode = "Invalid Post Code";
  static const String profileDetailsButtonText = "Complete";

  //base navigation screen
  static const String homeNavigationTabText = "Home";
  static const String categoryNavigationTabText = "Category";
  static const String cartNavigationTabText = "Cart";
  static const String wishListNavigationTabText = "Wish";

  //home screen
  static const String homeCategoryHeader = "All Categories";
  static const String homePopularHeader = "Popular";
  static const String homeSpecialHeader = "Special";
  static const String homeNewHeader = "New";
  static const String homeSeeAllButtonText = "See All";
  static const String offerCarouselButtonText = "Buy Now";

  //product details screen
  static const String productDetailsHeader = "Product Details";
  static const String productDescriptionHeader = "Description";
  static const String productColorHeader = "Color";
  static const String productSizeHeader = "Size";
  static const String productPriceHeader = "Price";
  static const String addToCartButtonText = "Add To Cart";
  static const String productReviewHeader = "Reviews";
  static const String stockOutText = "Stock Out";
  static const String noProductFoundText = "No data found for this product";

  //product review screen
  static const String noReviewFoundText = "No review found for this product";
  static const String addReviewHeader = "Create Review";
  static const String writeReviewHintText = "Write Review";
  static const String emptyReviewText = "Review is required";
  static const String reviewSubmitButtonText = "Submit";
  static const String reviewCreationSuccessMessage =
      "Your review has been added!";
  static const String reviewCreationFailedMessage = "Failed to add your review";
  static const String ratingBarHeaderText = "Give Rating";
  static const String unknownUserText = "Unknown user";

  //cart screen
  static const String cartViewHeader = "Cart";
  static const String noCartListFoundText = "Your cart is currently empty now";
  static const String cartDeletionFailureText = "Failed to delete cart item";
  static const String cartDeletionSuccessText =
      "Item has been removed from your cart";
  static const String cartLoginText = "Login to see your cart";

  //wishlist screen
  static const String wishListViewHeader = "Wish List";
  static const String noWishListFoundText = "Your wish list is currently empty";
  static const String wishListLoginText = "Login to see your wishlist";

  //search screen
  static const String searchWithNameText = "Search for a product with name";

  static String noSearchResultText(String query) =>
      "No Item found for \"$query\" query";

  //profile screen
  static const String profileScreenTitle = "Profile";
  static const String changeNameText = "Change Name";
  static const String changeShipAddressText = "Shipping Address";
  static const String changeContactNumberText = "Change Contact Number";
  static const String darkModeText = "Dark Mode";
  static const String logoutButtonText = "Logout";
  static const String updateButtonText = "Update";
  static const String profileUpdationSuccessText =
      "Profile has been updated successfully";
}
