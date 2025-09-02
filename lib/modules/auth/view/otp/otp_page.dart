import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/auth/controller/forget_password_controller.dart';
import 'package:tracking_system_app/modules/auth/controller/otp_timer_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/auth/number_fild_otp.dart';
import 'package:tracking_system_app/widgets/general/defult_button.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/shared/app_strings.dart';

class OtpPage extends StatelessWidget {
  final String email;
  OtpPage({
    super.key,
    required this.email,
  });

  final TimerController timerController = Get.put(TimerController());

  final ForgetPasswordController controller =
      Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    final AppStrings() = AppStrings();

    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(AppSizeW.s10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      AppStrings().verificationCode,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppVar.seconndTextColor
                            : AppVar.textColor,
                        fontWeight: AppVar.fontWeightBold,
                        fontSize: AppVar.mainFontSize,
                      ),
                    ),
                  ),
                  Text(
                    AppStrings().weHaveSentCode,
                    style: TextStyle(
                      color: Color(0xff45444B),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        Text(
                          controller
                              .maskEmailOtp(controller.emailController.text),
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppVar.seconndTextColor
                                    : AppVar.textColor,
                            fontWeight: AppVar.fontWeightBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomeNumberFildOTP(
                          onChanged: (value) {
                            if (value!.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                            print("$value");
                            controller.otpNumber1 = value;
                            controller.checkOtpComplete();
                          },
                          onSaved: (pin1) {}),
                      CustomeNumberFildOTP(
                          onChanged: (value) {
                            if (value!.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                            print("$value");
                            controller.otpNumber2 = value;
                            controller.checkOtpComplete();
                          },
                          onSaved: (pin2) {}),
                      CustomeNumberFildOTP(
                          onChanged: (value) {
                            if (value!.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                            print("$value");
                            controller.otpNumber3 = value;
                            controller.checkOtpComplete();
                          },
                          onSaved: (pin3) {}),
                      CustomeNumberFildOTP(
                          onChanged: (value) {
                            if (value!.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                            print("$value");
                            controller.otpNumber4 = value;
                            controller.checkOtpComplete();
                          },
                          onSaved: (pin4) {}),
                      CustomeNumberFildOTP(
                          onChanged: (value) {
                            if (value!.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                            print("$value");
                            controller.otpNumber5 = value;
                            controller.checkOtpComplete();
                          },
                          onSaved: (pin5) {}),
                      CustomeNumberFildOTP(
                          onChanged: (value) {
                            if (value!.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                            print("$value");
                            controller.otpNumber6 = value;
                            controller.checkOtpComplete();
                          },
                          onSaved: (pin6) {}),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppStrings().resendCodeAfter,
                            style: TextStyle(
                              color: Color(0xff45444B),
                            ),
                          ),
                          Obx(
                            () => Center(
                              child: Text(
                                timerController.timerText.value,
                                style: TextStyle(
                                  color: AppVar.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Obx(() => DefultButton(
                              textColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppVar.seconndTextColor
                                  : AppVar.textColor,
                              buttonColor: timerController.isTimerRunning.value
                                  ? Colors.grey
                                  : Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppVar.darkTheme.scaffoldBackgroundColor
                                      : AppVar.seconndTextColor,
                              borderColor: timerController.isTimerRunning.value
                                  ? AppVar.secondarySoft
                                  : AppVar.primary,
                              title: AppStrings().resend,
                              onPressed: timerController.isTimerRunning.value
                                  ? () {}
                                  : () async {
                                      log(email);
                                      await controller.customerForgetPassword(
                                          email: email);
                                    },
                            )),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                        horizontal: AppVar.paddingprimary / 2,
                      )),
                      Expanded(
                        child: Obx(() {
                          return DefultButton(
                            textColor: AppVar.seconndTextColor,
                            buttonColor: controller.isOtpComplete.value
                                ? AppVar.primary
                                : Colors.grey,
                            borderColor: AppVar.primary,
                            title: AppStrings().confirm,
                            onPressed: !controller.isOtpComplete.value
                                ? () {}
                                : () async {
                                    await controller.customerCheckCode();
                                  },
                          );
                        }),
                      ),
                    ],
                  )
                ],
              ),
            )),
        Obx(() {
          if (controller.isLoading.value) {
            return Container(
              color: Colors.black.withValues(alpha: .5),
              child: const Center(
                child: MainLoadingWidget(),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
