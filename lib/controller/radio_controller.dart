
import 'package:get/get.dart';

class RadioController extends GetxController {
  var selectedValue = Rx<int?>(null);

  void setSelectedValue(int value) {
    selectedValue.value = value;
  }
    int? getSelectedValue() {
    return selectedValue.value;
  }
}