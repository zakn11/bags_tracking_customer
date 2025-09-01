import 'package:get/get.dart';
import 'package:tracking_system_app/model/get_customer_info.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPhoneUpdating = false.obs;
  RxBool isEmailUpdating = false.obs;

  Rx<GetCustomerInfo> getCustomerInfo = GetCustomerInfo(
    id: 0,
    firstName: "",
    lastName: "",
    phone: "",
    email: "",
    role: "",
    isActive: true,
    address: "",
    area: "",
    driverName: "",
    subscriptionStartDate: "",
    subscriptionExpiryDate: "",
    subscriptionStatus: 0,
    bagsAssigned: [],
  ).obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    isLoading.value = true;
    try {
      var response = await $.get('/getCustomerInfo');
      if (response != null) {
        getCustomerInfo.value = GetCustomerInfo.fromJson(response["data"]);
      }
    } catch (e) {
      CustomToast.errorToast("Opps..", "Failed to load your info");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateInfoByCustomer({
    required String? phone,
    required String? email,
  }) async {
    if (phone != null) isPhoneUpdating.value = true;
    if (email != null) isEmailUpdating.value = true;

    try {
      Map<String, dynamic> requestBody = {};
      if (phone != null) requestBody["phone"] = phone;
      if (email != null) requestBody["email"] = email;

      var response = await $.post('/updateInfoByCustomer', body: requestBody);

      if (response != null) {
        getCustomerInfo.value = GetCustomerInfo.fromJson(response["data"]);
      }
    } catch (e) {
      CustomToast.errorToast("Opps..", "Failed to update your info");
    } finally {
      if (phone != null) isPhoneUpdating.value = false;
      if (email != null) isEmailUpdating.value = false;
    }
  }
}
