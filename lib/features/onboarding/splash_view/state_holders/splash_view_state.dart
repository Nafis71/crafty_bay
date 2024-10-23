import 'package:get/get.dart';

class SplashViewState extends GetxController {
  bool _isBusy = false;
  bool _hasShownSnackBar = false;

  bool get isBusy => _isBusy;

  bool get hasShownSnackBar => _hasShownSnackBar;

  set setIsBusy(bool isBusy) => _isBusy = isBusy;

  set setHasShownSnackBar(bool hasShownSnackBar) =>
      _hasShownSnackBar = hasShownSnackBar;
}
