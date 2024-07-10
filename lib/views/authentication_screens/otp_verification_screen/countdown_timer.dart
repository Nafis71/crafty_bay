import 'package:flutter/foundation.dart';

class CountdownTimer extends ChangeNotifier{
  int _timeLeft = 120;

  int get timeLeft => _timeLeft;

  void resetTime(){
    if(_timeLeft != 120){
      _timeLeft = 120;
    }
  }

  void decreaseTime(){
    _timeLeft--;
    notifyListeners();
  }

}