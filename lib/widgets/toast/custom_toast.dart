import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/shared/app_strings.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class CustomToast {
  static errorToast(String? title, String? message) {
    Get.rawSnackbar(
      duration: const Duration(seconds: 4),
      dismissDirection: DismissDirection.horizontal,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/info-circle.svg",
            color: Colors.white,
          ),
          SizedBox(width: AppSizeW.s16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: AppSizeH.s4),
                  child: Text(
                    title ?? AppStrings().error,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins',
                    ),
                  ),
                ),
                Text(
                  message ??AppStrings().addYourErrorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: AppVar.error,
      padding: EdgeInsets.symmetric(horizontal: AppSizeW.s16, vertical: AppSizeH.s10),
      margin: EdgeInsets.symmetric(horizontal: AppSizeW.s16),
      borderRadius: AppSizeR.s8,
      snackPosition: SnackPosition.TOP,
    );
  }

  static successToast(String? title, String? message) {
    Get.rawSnackbar(
      duration: const Duration(seconds: 4),
      dismissDirection: DismissDirection.horizontal,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/success-circle.svg",
            color: Colors.white,
          ),
          SizedBox(width: AppSizeW.s16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: AppSizeH.s4),
                  child: Text(
                    title ??AppStrings().success,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins',
                    ),
                  ),
                ),
                Text(
                  message ?? AppStrings().addYourSuccessMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: AppVar.success,
      padding: EdgeInsets.symmetric(horizontal: AppSizeW.s16, vertical: AppSizeH.s10),
      margin: EdgeInsets.symmetric(horizontal: AppSizeW.s16),
      borderRadius: AppSizeR.s8,
      snackPosition: SnackPosition.TOP,
    );
  }
}
