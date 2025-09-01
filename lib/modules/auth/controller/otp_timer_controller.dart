import 'dart:async';
import 'package:get/get.dart';

class TimerController extends GetxController {
  var timerText = '5:00'.obs; 
  var isTimerRunning = true.obs; 
  Timer? _timer;
  int _secondsLeft = 300; // 5 minutes in seconds

  void startTimer() {
    isTimerRunning.value = true;
    _secondsLeft = 300; 
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 0) {
        timer.cancel();
        isTimerRunning.value = false; // Enable the resend button
        timerText.value = "0:00";
      } else {
        int minutes = _secondsLeft ~/ 60;
        int seconds = _secondsLeft % 60;
        timerText.value = '$minutes:${seconds.toString().padLeft(2, '0')}';
        _secondsLeft--;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }
}
