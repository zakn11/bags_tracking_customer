import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_system_app/modules/auth/controller/forget_password_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/auth/costume_login_TextField_widget.dart';
import 'package:tracking_system_app/widgets/auth/login-defult_button.dart';

class ForgetPasswordScreenMobileLayout
    extends GetView<ForgetPasswordController> {
  ForgetPasswordScreenMobileLayout(BuildContext context, {super.key});
  final forgetPasswordController =
      Get.put(ForgetPasswordController(), permanent: false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: AppVar.background
                // MediaQuery.of(context).orientation == Orientation.landscape
                //     ? AppVar.background
                //     : AppVar.primary
                ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        backgroundColor: AppVar.primary,
        // MediaQuery.of(context).orientation == Orientation.landscape &&
        //         !controller.isWaitAdminApproved.value
        //     ? AppVar.primary
        //     : controller.isWaitAdminApproved.value
        //         ? AppVar.primary
        //         : AppVar.background,
        body: OrientationBuilder(builder: (context, orientation) {
          final screenWidth = MediaQuery.sizeOf(context).width;
          final screenHeight = MediaQuery.sizeOf(context).height;
          final isLandscape =
              MediaQuery.of(context).orientation == Orientation.landscape;
          // if (orientation == Orientation.landscape) {
          //   return const Text("landing");
          // } else {
          return Stack(
            children: [
              // if (!isLandscape)
              //   Positioned(
              //     bottom: 0,
              //     child: Image(
              //       width:
              //           //for DONE message
              //           controller.isWaitAdminApproved.value
              //               ? 0
              //               : screenWidth <= 400 && screenHeight < 700
              //                   ? screenWidth
              //                   : screenWidth + 70,
              //       image: const AssetImage('assets/images/Rectingle.jpg'),
              //       fit:
              //           // avarige >= 895 ||
              //           //         avarige == 630 && !isLandscape
              //           //     ? BoxFit.fill
              //           //     :
              //           BoxFit.cover,
              //     ),
              //   ),
              // Waiting for admin approval (Lottie Animation)
              SingleChildScrollView(
                child: Obx(() {
                  if (controller.isWaitAdminApproved.value) {
                    return
                        // Positioned(
                        //   // bottom: MediaQuery.sizeOf(context).height * 0.15,
                        //   right: 0,
                        //   left: 0,
                        // child:
                        Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!isLandscape) SizedBox(height: AppSizeH.s20),
                        if (!isLandscape)
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1000),
                                    color: AppVar.background,
                                    border: Border.all(
                                        width: 3, color: AppVar.primary)),
                                width: AppSizeW.s150,
                                height: AppSizeH.s150,
                                child: Image.asset(
                                  "assets/images/Logo1.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        Center(
                          child: LottieBuilder.asset(
                            "assets/Lottie/Animation - 1726871315481.json",
                            width: AppSizeW.s200,
                            height: AppSizeH.s200,
                            repeat: false,
                            fit: BoxFit.fill,
                          ),
                        ),
                        if (!isLandscape) SizedBox(height: AppSizeH.s20),
                        Text(
                          "Done!",
                          style: TextStyle(
                            color: const Color(0xff1CB26B),
                            fontSize: AppSizeSp.s30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: AppSizeH.s20),
                          padding: EdgeInsets.symmetric(
                              vertical: AppSizeH.s5, horizontal: AppSizeW.s15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: const Color(0xff1CB26B),
                            ),
                            borderRadius: BorderRadius.circular(AppSizeR.s10),
                          ),
                          child: Text(
                            "Waiting for admin approval",
                            style: TextStyle(
                              color: AppVar.seconndTextColor,
                              fontSize: AppSizeSp.s16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      // ),
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
              Positioned(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizeW.s40,
                      // isTablet ? 80.0 : 40.0,
                      // vertical: isLandscape
                      //     ? AppSizeH.s20
                      //     : screenWidth <= 400 && screenHeight < 700
                      //         ? 0
                      //         : screenWidth * 0.3
                      // isLandscape
                      //     ? 20 : 30
                      //     : 40.0,
                    ),
                    child: Obx(
                      () => Opacity(
                        opacity: controller.isWaitAdminApproved.value ? 0 : 1,
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            // mainAxisAlignment: isLandscape
                            //     ? MainAxisAlignment.start
                            //     : MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: AppSizeH.s20),
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        color: AppVar.background,
                                        border: Border.all(
                                            width: 3, color: AppVar.primary)),
                                    width: AppSizeW.s150,
                                    height: AppSizeH.s150,
                                    child: Image.asset(
                                      "assets/images/Logo1.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //     height: isLandscape
                              //         ? 0
                              //         : screenHeight > 800 &&
                              //                 screenWidth < 400
                              //             ? screenWidth * 0.4
                              //             : screenWidth *
                              //                 0.19),

                              SizedBox(height: AppSizeH.s30),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: AppSizeH.s40),
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppSizeH.s20,
                                        horizontal: AppSizeW.s20),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: AppVar.background),
                                      borderRadius:
                                          BorderRadius.circular(AppSizeR.s20),
                                    ),
                                    child: Column(
                                      children: [
                                        CustomeLoginTextFormField(
                                          isFilledTextFild: false,
                                          filledTextFildData: "",
                                          prefixIcon: null,
                                          inputType: TextInputType.text,
                                          hintText: 'Full Name',
                                          title: 'Full Name',
                                          controller:
                                              controller.fullNameController,
                                          validator: null,
                                        ),
                                        // CustomeLoginTextFormField(
                                        //   isFilledTextFild: false,
                                        //   filledTextFildData: "",
                                        //   prefixIcon: null,
                                        //   inputType: TextInputType.text,
                                        //   hintText: 'Phone Number',
                                        //   title: 'Phone Number',
                                        //   controller: controller
                                        //       .phoneNumberController,
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
                      AppSizeSp.s14),
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

            initialCountryCode: 'AE', // 🇦🇪
            onChanged: (phone) {
              print(phone.completeNumber); 
            },
          ),
        ),
                                        // CustomeLoginTextFormField(
                                        //   isFilledTextFild: false,
                                        //   filledTextFildData: "",
                                        //   hintText: 'Phone Number',
                                        //   inputType: TextInputType.number,
                                        //   title: 'Phone Number',
                                        //   prefixIcon: Padding(
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 8.0),
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
                                        //           padding: const EdgeInsets
                                        //               .symmetric(horizontal: 5),
                                        //           decoration:
                                        //               const BoxDecoration(
                                        //                   border: Border(
                                        //             right: BorderSide(
                                        //               color: AppVar
                                        //                   .seconndTextColor,
                                        //               width: 1.0,
                                        //             ),
                                        //           )),
                                        //           child: const Text(
                                        //             '+971',
                                        //             style: TextStyle(
                                        //               fontSize: 14,
                                        //               color: AppVar
                                        //                   .seconndTextColor,
                                        //               fontWeight:
                                        //                   FontWeight.bold,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        //   controller:
                                        //       controller.phoneNumberController,
                                        //   validator: null,
                                        // ),
                                        CustomeLoginTextFormField(
                                          prefixIcon: null,
                                          inputType: TextInputType.text,
                                          hintText: 'New Password',
                                          title: 'Password',
                                          controller:
                                              controller.passwordController,
                                          validator: null,
                                          isFilledTextFild: false,
                                          filledTextFildData: "",
                                        ),
                                        CustomeLoginTextFormField(
                                          prefixIcon: null,
                                          inputType: TextInputType.text,
                                          hintText: 'Confirm New Password',
                                          title: 'Password',
                                          controller: controller
                                              .confirmPasswordController,
                                          validator: null,
                                          isFilledTextFild: false,
                                          filledTextFildData: "",
                                        ),
                                        SizedBox(
                                          height: AppSizeH.s30,
                                        ),
                                        //4
                                        Center(
                                          child: SizedBox(
                                            width: AppSizeW.s150,
                                            child: LoginDefultButton(
                                              fontsize: AppSizeSp.s14,
                                              buttonColor:
                                                  const Color(0xff1CB26B),
                                              borderColor: Colors.transparent,
                                              textColor:
                                                  AppVar.seconndTextColor,
                                              title: "Send to admin",
                                              onPressed: () {
                                                if (controller
                                                    .formKey.currentState!
                                                    .validate()) {
                                                  controller.validateForm();
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //2======================
                                  Positioned(
                                    top: AppSizeH.s25,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: AppSizeH.s5,
                                            horizontal: AppSizeW.s15),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: AppVar.background),
                                          borderRadius: BorderRadius.circular(
                                              AppSizeR.s20),
                                          color: AppVar.primary,
                                        ),
                                        child: const Text(
                                          "Forget Password",
                                          style: TextStyle(
                                            color: AppVar.seconndTextColor,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          
            ],
          );
        }
            // },
            ),
      ),
    );
  }
}
