import 'package:get/get.dart';
import 'package:tracking_system_app/modules/contact_us/controller/contact_us_controller.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactUsController>(() => ContactUsController());
  }
}
