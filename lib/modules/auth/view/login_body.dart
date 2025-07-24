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
            height: isLandscape
                ? screenHeight * 0.05
                : screenWidth * 0.15),
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
        // CustomeLoginTextFormField(
        //   hintText: 'Phone Number',
        //   inputType: TextInputType.number,
        //   title: 'Phone Number',
        //   prefixIcon: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //     child: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Image.asset(
        //           'assets/images/uae_flag.png',
        //           width: 24,
        //           height: 24,
        //         ),
        //         const SizedBox(width: 5),
        //         Container(
        //           padding: const EdgeInsets.symmetric(horizontal: 5),
        //           decoration: const BoxDecoration(
        //               border: Border(
        //             right: BorderSide(
        //               color: AppVar.seconndTextColor,
        //               width: 1.0,
        //             ),
        //           )),
        //           child: const Text(
        //             '+971',
        //             style: TextStyle(
        //               fontSize: 14,
        //               color: AppVar.seconndTextColor,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   controller: controller.phoneNumberController,
        //   validator: null,
        // ),

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
                  fontSize:
                      textFieldFontSize * 0.9),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AppVar.secondarySoft, width: 2.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AppVar.secondary, width: 2.0), 
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
        Center(
          child: LoginDefultButton(
            fontsize: AppVar.mainFontSize,
            buttonColor: const Color(0xff1CB26B),
            borderColor: Colors.transparent,
            textColor: AppVar.seconndTextColor,
            title: "SIGN IN",
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                controller.validateForm();
              }
            },
          ),
        ),
        // const SizedBox(height: 15),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 30.0),
        //   child: Center(
        //     child: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Text(
        //           "Don't have an account? ",
        //           style: TextStyle(
        //             color: AppVar.seconndTextColor,
        //             fontSize: AppVar.littelFontSize,
        //           ),
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             Get.toNamed(Routes.REGISTER);
        //           },
        //           child: DecoratedBox(
        //             decoration: const BoxDecoration(
        //               border: Border(
        //                   bottom: BorderSide(color: Colors.white, width: 1.0)),
        //             ),
        //             child: Text(
        //               "Sign up",
        //               style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: AppVar.littelFontSize,
        //                 color: const Color(0xff1CB26B),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ), 
        // ),
      ],
    );
  }
}
