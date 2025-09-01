import 'package:get/get.dart';
import 'package:tracking_system_app/model/my_order_response_model.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class OrdersController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isDeleteLoading = false.obs;

  RxList<MyOrderResponseModel> myOrderResponseModel =
      <MyOrderResponseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    myOrderResponseModel.clear();
    isLoading.value = true;
    try {
      var response = await $.get('/order/getMyOrders');
      print(response);

      if (response != null) {
        for (int i = 0; i < response["result"].length; i++) {
          myOrderResponseModel
              .add(MyOrderResponseModel.fromJson(response["result"][i]));
        }
      }
    } catch (e) {
      print("Error: $e");
      CustomToast.errorToast("Opps..", "Failed to load the orders");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteOrder({required int id}) async {
    isDeleteLoading.value = true;
    try {
      var response = await $.delete('/order/deleteOrder/$id');
      print(response);

      if (response != null) {
        initialize();
      }
    } catch (e) {
      print("Error: $e");
      CustomToast.errorToast("Opps..", "Failed to delete the order");
    } finally {
      isDeleteLoading.value = false;
    }
  }
}
