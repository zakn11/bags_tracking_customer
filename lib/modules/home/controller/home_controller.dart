import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/model/get_all_meals_model.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/widgets/home/custome_message_dialog.dart';
import 'package:tracking_system_app/widgets/home/custome_sign_out_dialog.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class HomeController extends GetxController {
  RxInt selectedCardIndex = (-1).obs;
  final TextEditingController issueDialogController = TextEditingController();
  RxBool isTextFildFilled = false.obs;
  RxBool isLoading = false.obs;
  RxBool isConfirmitionLoading = false.obs;
  RxBool isMyInfoLoading = false.obs;
  RxBool showLottieAnimation = false.obs;
  RxBool showLottieAnimationForConfirmation = false.obs;
  Rx<GetAllMealsModel> getAllMealsModel = GetAllMealsModel(meals: []).obs;
  RxList<int> selectedMealIds = <int>[].obs;

  //==============Zak's Editation=======================

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

//===========================================Search========================================
  RxString searchQuery = "".obs;

  List<MealModel> get filteredMeals {
    if (searchQuery.isEmpty) {
      return getAllMealsModel.value.meals;
    }
    return getAllMealsModel.value.meals.where((meal) {
      final query = searchQuery.value.toLowerCase();
      return meal.name.toLowerCase().contains(query) ||
          meal.description.toLowerCase().contains(query);
    }).toList();
  }

//===========================================Meals========================================
  void toggleMealSelection(int mealId) {
    if (selectedMealIds.contains(mealId)) {
      selectedMealIds.remove(mealId);
    } else {
      if (selectedMealIds.length >= 2) {
        CustomToast.errorToast("Oops", "You can only select 2 meals");
      } else {
        selectedMealIds.add(mealId);
      }
    }
  }

  //send order to backend
  Future<void> confirmSelectedMeals() async {
    if (selectedMealIds.length != 2) {
      CustomToast.errorToast("Validation", "Please select exactly 2 meals");
      return;
    }
    print(selectedMealIds[0]);
    print(selectedMealIds[1]);
    try {
      isConfirmitionLoading.value = true;
      final response = await $.post(
        "order/addOrder",
        body: {
          "meal1_id": selectedMealIds[0],
          "meal2_id": selectedMealIds[1],
        },
      );
      if (response != null) {
        showLottieAnimationForConfirmation.value = true;
        selectedMealIds.value = [];
        await Future.delayed(const Duration(seconds: 3));
        CustomToast.successToast("Success", "Meals confirmed successfully");
      }
      print(response);
    } catch (e) {
      CustomToast.errorToast("Error", "Error: ${e.toString()}");
    } finally {
      showLottieAnimationForConfirmation.value = false;

      isConfirmitionLoading.value = false;
    }
  }

  Future<void> initialize() async {
    isLoading.value = true;
    try {
      var response = await $.get('/getAllMeal/1');
      print(response);

      if (response != null) {
        getAllMealsModel.value = GetAllMealsModel.fromJson(response["data"]);
      }
    } catch (e) {
      print("Error: $e");
      CustomToast.errorToast("Opps..", "Failed to load my info");
    } finally {
      isLoading.value = false;
    }
  }
//===========================================Messaging dialog================================================================

  Future<void> sendToAdmin() async {
    isLoading.value = true;
    try {
      final response = await $.post('/message/sendMessage', body: {
        "data": issueDialogController.text,
      });

      if (response != null) {
        // await Future.delayed(Duration(seconds: 3));
        // // Show Lottie animation for 3 seconds
        showLottieAnimation.value = true;
        issueDialogController.clear();
        isTextFildFilled.value = false;
        isLoading.value = false;
        await Future.delayed(const Duration(seconds: 3));
        Get.back();
      }
    } catch (e) {
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
      showLottieAnimation.value = false;
      isLoading.value = false;
    }
  }

  void exitMessageDialog() {
    Get.back();
    isTextFildFilled.value = false;
    issueDialogController.clear();
  }

  void showCustomMessageDialog(
      BuildContext context, HomeController homeController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          return SingleChildScrollView(
              child: CustomMessageDialog(
                  title: "Welcome", subtitle: "How can we assest you today?"));
        } else {
          return CustomMessageDialog(
              title: "Welcome", subtitle: "How can we assest you today?");
        }
      },
    );
  }
//===========================================Sign out dialog================================================================

  void exitSignOutDialog() {
    Get.back();
  }

  void showCustomSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomSignOutDialog();
      },
    );
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await $.resetUser();

      isLoading.value = false;
    } catch (e) {
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
  //=================================== FCM token ==================================
   Future<void> sendFcmToken({required String fcmToken}) async {
    isLoading.value = true;
    try {
      final response = await $.post('/createFcmToken', body: {
        "fcm_token": fcmToken,
      });

      if (response != null) {
log("FCM RESPONSE: $response");
      }
    } catch (e) {
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
    }
  }
}
