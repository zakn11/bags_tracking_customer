// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:tracking_system_app/modules/auth/controller/login_controller.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/auth/costume_login_TextField_widget.dart';
import 'package:tracking_system_app/widgets/auth/login-defult_button.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
    required this.isLandscape,
    required this.screenHeight,
    required this.screenWidth,
  });

  final bool isLandscape;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSizeW.s16,
          //IF TAPLATE
          vertical: screenWidth > 850 ? 40 : 0),
      child: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Form(
            key: controller.formKey,
            child: isLandscape
                ? LoginBodyBody(
                    controller: controller,
                    isLandscape: isLandscape,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth)
                : ListView(
                    children: [
                      LoginBodyBody(
                          controller: controller,
                          isLandscape: isLandscape,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class LoginBodyBody extends StatelessWidget {
  const LoginBodyBody({
    super.key,
    required this.isLandscape,
    required this.screenHeight,
    required this.screenWidth,
    required this.controller,
  });

  final bool isLandscape;
  final double screenHeight;
  final double screenWidth;
  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    final textFieldFontSize = screenWidth *
        (isLandscape
            ? 0.03
            : screenWidth > 600
                ? 0.02
                : 0.04);
    return Column(
      mainAxisAlignment:
          isLandscape ? MainAxisAlignment.start : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSizeH.s20),
        Padding(
          padding: screenWidth > 850
              ? const EdgeInsets.all(0)
              : EdgeInsets.only(top: isLandscape ? AppSizeH.s20 : AppSizeH.s40),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: AppVar.background,
                    border: Border.all(width: 3, color: AppVar.primary)),
                width: AppSizeW.s150,
                height: AppSizeH.s150,
                child: Image.asset(
                  "assets/images/Logo1.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
            height: isLandscape ? screenHeight * 0.05 : screenWidth * 0.15),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0, top: 30),
          child: Text(
            "Sign In",
            style: TextStyle(
              color: AppVar.seconndTextColor,
              fontSize: AppSizeSp.s40,
              shadows: const [
                Shadow(
                  color: Color.fromARGB(255, 79, 79, 79),
                  offset: Offset(2, 4),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
        ),

        Theme(
          data: Theme.of(context).copyWith(
            primaryColor: AppVar.primary,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppVar.primary,
                ),
          ),
          child: IntlPhoneField(
            controller: controller.phoneNumberController,
            decoration: InputDecoration(
              isDense: true,
              fillColor: Colors.transparent,
              filled: true,
              hintText: 'Phone Number',
              hintStyle: TextStyle(
                  color: const Color.fromARGB(197, 255, 255, 255),
                  fontSize: textFieldFontSize * 0.9),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppVar.secondarySoft, width: 2.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppVar.secondary, width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizeR.s10),
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizeR.s10),
                borderSide:
                    const BorderSide(color: Colors.redAccent, width: 2.0),
              ),
              errorStyle: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: AppSizeH.s15,
              ),
            ),
            initialCountryCode: 'AE',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
          ),
        ),
        CustomeLoginTextFormField(
          prefixIcon: null,
          inputType: TextInputType.text,
          hintText: '••••••••••••••••',
          title: 'Password',
          controller: controller.passwordController,
          validator: null,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.FORGOT_PASSWORD);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizeH.s15),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot password?",
                style: TextStyle(
                    fontSize: AppSizeSp.s13, color: AppVar.seconndTextColor),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Obx(() {
          return Center(
            child: LoginDefultButton(
              fontsize: AppVar.mainFontSize,
              buttonColor: controller.isButtonLooked.value ||
                      controller.isButtonLookedPermently.value
                  ? AppVar.primarySoft
                  : const Color(0xff1CB26B),
              borderColor: Colors.transparent,
              textColor: controller.isButtonLookedPermently.value
                  ? Colors.black.withValues(alpha: .2)
                  : AppVar.seconndTextColor,
              title: controller.isButtonLooked.value
                  ? "Try again in ${controller.lockoutTimer.value}s"
                  : "SIGN IN",
              onPressed: controller.isButtonLooked.value ||
                      controller.isButtonLookedPermently.value
                  ? () {}
                  : () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.validateForm();
                      }
                    },
            ),
          );
        }),
        //------------ zak ----------------------
        Obx(() {
          if (controller.isBiometricAvailable.value) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, .4),
                                  blurRadius: 1)
                            ]),
                        width: AppSizeW.s100,
                        height: AppSizeH.s1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSizeW.s5),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppSizeSp.s9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: AppSizeW.s100,
                        height: AppSizeH.s1,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, .4),
                                  blurRadius: 1)
                            ]),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: AppSizeH.s20),
                Obx(() {
                  return Opacity(
                    opacity: controller.fingerprintOpacity.value,
                    child: GestureDetector(
                      onTap: controller.authenticateWithBiometrics,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(top: AppSizeW.s10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppVar.primary,
                              width: AppSizeW.s2,
                            ),
                          ),
                          child: Icon(
                            Icons.fingerprint,
                            size: AppSizeW.s40,
                            color: AppVar.seconndTextColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                // SizedBox(height: AppSizeH.s10),
                Center(
                  child: Opacity(
                    opacity: controller.fingerprintOpacity.value,
                    child: Text(
                      'Use Fingerprint',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppSizeSp.s12,
                      ),
                    ),
                  ),
                ),
                if (controller.isFirstLogin.value) ...[
                  SizedBox(height: AppSizeH.s10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizeW.s40),
                    child: Text(
                      'Available after first manual login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: AppSizeSp.s10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
