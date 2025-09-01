import 'package:get/get.dart';
import 'package:tracking_system_app/modules/orders/controller/orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(() => OrdersController());
  }
}
