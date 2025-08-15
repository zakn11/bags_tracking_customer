import 'package:get/get.dart';
import 'package:tracking_system_app/modules/notifactions/controller/notifaction_controller.dart';

class NotifactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifactionController>(() => NotifactionController());
  }
}
