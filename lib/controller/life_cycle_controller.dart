import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LifecycleController extends GetxController with WidgetsBindingObserver {
  RxBool isInQrScanView = false.obs;

  void enterQrScanView() {
    isInQrScanView.value = true;
  }

  void exitQrScanView() {
    isInQrScanView.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
