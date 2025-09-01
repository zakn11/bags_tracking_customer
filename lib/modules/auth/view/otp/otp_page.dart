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
                  //1
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Verification code",
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppVar.seconndTextColor
                            : AppVar.textColor,
                        fontWeight: AppVar.fontWeightBold,
                        fontSize: AppVar.mainFontSize,
                      ),
                    ),
                  ),
                  //2
                  const Text(
                    "We have sent the code verification to",
                    style: TextStyle(
                      color: Color(0xff45444B),
                    ),
                  ),
                  //3
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
                  //4
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //NOTE: here i will Save the PINs Data
                      CustomeNumberFildOTP(
                          onChanged: (value) {
                            if (value!.length == 1) {
                              //to go to another textfild directly
                              FocusScope.of(context).nextFocus();
                            }
                            print("$value");
                            controller.otpNumber1 = value;
                            controller.checkOtpComplete();
                          },
                          onSaved: (pin1) {}),
                      CustomeNumberFildOTP(onChanged: (value) {
                        if (value!.length == 1) {
                          //to go to another textfild directly
                          FocusScope.of(context).nextFocus();
                        }
                        print("$value");
                        controller.otpNumber2 = value;
                        controller.checkOtpComplete();
                      }, onSaved: (pin2) {
                        // controller.otpNumber2 = pin2;
                      }),
                      CustomeNumberFildOTP(onChanged: (value) {
                        if (value!.length == 1) {
                          //to go to another textfild directly
                          FocusScope.of(context).nextFocus();
                        }
                        print("$value");
                        controller.otpNumber3 = value;
                        controller.checkOtpComplete();
                      }, onSaved: (pin3) {
                        // controller.otpNumber3 = pin3;
                      }),
                      CustomeNumberFildOTP(
                          onChanged: (value) {
                            if (value!.length == 1) {
                              //to go to another textfild directly
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
                              //to go to another textfild directly
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
                              //to go to another textfild directly
                              FocusScope.of(context).nextFocus();
                            }
                            print("$value");
                            controller.otpNumber6 = value;
                            controller.checkOtpComplete();
                          },
                          onSaved: (pin6) {}),
                    ],
                  ),
                  //5
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Resend code after ",
                            style: TextStyle(
                              color: Color(0xff45444B),
                            ),
                          ),
                          Obx(
                            () => Center(
                              child: Text(
                                timerController
                                    .timerText.value, // Display timer value
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

                  //6
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
                              title: "Resend",
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
                            title: "Confirm",
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
            return const SizedBox.shrink(); // Empty container when not loading
          }
        }),
      ],
    );
  }
}
