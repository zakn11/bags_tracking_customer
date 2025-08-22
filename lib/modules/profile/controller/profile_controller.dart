import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/model/get_customer_info.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class ProfileController extends GetxController {
   RxInt selectedCardIndex = (-1).obs;
  final TextEditingController issueDialogController = TextEditingController();
  RxBool isTextFildFilled = false.obs;
  RxBool isLoading = false.obs;
  RxBool isMyInfoLoading = false.obs;
  Rx<GetCustomerInfo> getCustomerInfo  = GetCustomerInfo (id: 0, firstName: "", lastName:"", 
  phone: "", email:"", role: "", isActive:true, address:"", area: "",
   driverName:"", subscriptionStartDate: "", subscriptionExpiryDate: "", 
   subscriptionStatus: 0, bagsAssigned: []).obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

   Future<void> initialize() async {
    isLoading.value = true;
    try {
      var response = await $.get('/getCustomerInfo');
      print(response);

      if (response != null) {
        getCustomerInfo.value = GetCustomerInfo.fromJson(response["data"]);
      }

    } catch (e) {
      print("Error: $e");
      CustomToast.errorToast("Opps..", "Failed to load my info");
    } finally {
      isLoading.value = false;
    }
  }}