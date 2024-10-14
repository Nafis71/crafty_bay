import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkState extends GetxController {
  InternetConnectionChecker connectionChecker = InternetConnectionChecker();
  late StreamSubscription<InternetConnectionStatus> subscription;
  bool hasInternet = false;

  void initialize() {
    subscription = connectionChecker.onStatusChange.listen(
      (InternetConnectionStatus status) {
        if (status == InternetConnectionStatus.connected) {
          hasInternet = true;
          update();
        } else {
          hasInternet = false;
          update();
        }
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
