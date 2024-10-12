import 'package:get/get.dart';

class CountdownTimer extends GetxController {
  int _timeLeft = 120;

  int get timeLeft => _timeLeft;

  void resetTime() {
    if (_timeLeft != 120) {
      _timeLeft = 120;
    }
  }

  void decreaseTime() {
    _timeLeft--;
    update();
  }
}
