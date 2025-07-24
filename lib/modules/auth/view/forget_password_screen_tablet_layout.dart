import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_system_app/modules/auth/controller/forget_password_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/auth/costume_login_TextField_widget.dart';
import 'package:tracking_system_app/widgets/auth/login-defult_button.dart';

class ForgetPasswordScreenTapletLayout
    extends GetView<ForgetPasswordController> {
  ForgetPasswordScreenTapletLayout(BuildContext context, {super.key});
  final forgetPasswordController =
      Get.put(ForgetPasswordController(), permanent: false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          backgroundColor:
              MediaQuery.of(context).orientation == Orientation.landscape &&
                      !controller.isWaitAdminApproved.value
                  ? AppVar.primary
                  : controller.isWaitAdminApproved.value
                      ? AppVar.primary
                      : AppVar.background,
          body: OrientationBuilder(
            builder: (context, orientation) {
              final screenWidth = MediaQuery.sizeOf(context).width;
              final screenHeight = MediaQuery.sizeOf(context).height;
              final isTablet =
                  screenWidth > 600;
              final isLandscape =
                  MediaQuery.of(context).orientation == Orientation.landscape;
              // if (orientation == Orientation.landscape) {
              //   return const Text("landing");
              // } else {
              return Stack(
                children: [
                  if (!isLandscape)
                    Positioned(
                      bottom: 0,
                      child: Image(
                        width:
                            //for DONE message
                            controller.isWaitAdminApproved.value
                                ? 0
                                : screenWidth,
                        image: const AssetImage('assets/images/Rectingle.jpg'),
                        fit:
                            // avarige >= 895 ||
                            //         avarige == 630 && !isLandscape
                            //     ? BoxFit.fill
                            //     :
                            BoxFit.cover,
                      ),
                    ),
                  Obx(() {
                    // if (controller.isLoading.value) {
                    //   if (Get.isDialogOpen!) {
                    //     Get.back(); 
                    //   }
                    //   Get.dialog(
                    //     const Center(
                    //       child: MainLoadingWidget(),
                    //     ),
                    //     barrierDismissible:
                    //         false, 
                    //   );
                    // }

                    if (controller.isWaitAdminApproved.value) {
                      return
                          //  Positioned(
                          //   bottom: MediaQuery.sizeOf(context).height * 0.15,
                          //   right: 0,
                          //   left: 0,
                          // child:
                          Column(
                        children: [
                          SizedBox(height: AppSizeH.s20),
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
                          SizedBox(height: AppSizeH.s20),
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
                  Positioned(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSizeW.s40,
                            // isTablet ? 80.0 : 40.0,
                            vertical: screenWidth <= 400 && screenHeight < 700
                                ? 0
                                : isLandscape
                                    ? AppSizeW.s80
                                    : screenWidth * 0.2
                 
                            ),
                        child: Obx(
                          () => Opacity(
                            opacity:
                                controller.isWaitAdminApproved.value ? 0 : 1,
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                // mainAxisAlignment: isLandscape
                                //     ? MainAxisAlignment.start
                                //     : MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // const SizedBox(height: 20),
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(1000),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                            color: AppVar.background,
                                            border: Border.all(
                                                width: 3,
                                                color: AppVar.primary)),
                                        width: screenWidth * 0.2,
                                        height: screenWidth * 0.2,
                                        child: Image.asset(
                                          "assets/images/Logo1.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //     height: screenHeight > 800 &&
                                  //             screenWidth < 400
                                  //         ? screenWidth * 0.4
                                  //         : screenWidth * 0.19), 

                                  SizedBox(height: AppSizeH.s50),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: AppSizeH.s40),
                                        padding: EdgeInsets.symmetric(
                                            vertical: AppSizeH.s20, horizontal: AppSizeW.s20),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3,
                                              color: AppVar.background),
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
                                            //   title: 'Employee ID',
                                            //   controller: controller
                                            //       .phoneNumberController,
                                            //   validator: null,
                                            // ),
                                            CustomeLoginTextFormField(
                                              isFilledTextFild: false,
                                              filledTextFildData: "",
                                              hintText: 'Phone Number',
                                              inputType: TextInputType.number,
                                              title: 'Phone Number',
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/uae_flag.png',
                                                      width: 24,
                                                      height: 24,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5),
                                                      decoration:
                                                          const BoxDecoration(
                                                              border: Border(
                                                        right: BorderSide(
                                                          color: AppVar
                                                              .seconndTextColor,
                                                          width: 1.0,
                                                        ),
                                                      )),
                                                      child: const Text(
                                                        '+971',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: AppVar
                                                              .seconndTextColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              controller: controller
                                                  .phoneNumberController,
                                              validator: null,
                                            ),
                                            CustomeLoginTextFormField(
                                              prefixIcon: null,
                                              inputType: TextInputType.text,
                                              hintText: 'Password',
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
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            //4
                                            Center(
                                              child: SizedBox(
                                                width: screenWidth *
                                                    (isLandscape ? 0.3 : 0.4),
                                                child: LoginDefultButton(
                                                  fontsize: screenWidth *
                                                      (isLandscape
                                                          ? 0.017
                                                          : 0.021),
                                                  buttonColor:
                                                      const Color(0xff1CB26B),
                                                  borderColor:
                                                      Colors.transparent,
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
                                        top: 25,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: AppSizeH.s5, horizontal: AppSizeW.s15),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 3,
                                                  color: AppVar.background),
                                              borderRadius:
                                                  BorderRadius.circular(AppSizeR.s20),
                                              color: AppVar.primary,
                                            ),
                                            child: Text(
                                              "Forget Password",
                                              style: TextStyle(
                                                fontSize: screenWidth *
                                                    (isLandscape
                                                        ? 0.03
                                                        : isTablet
                                                            ? 0.02
                                                            : 0.04),
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
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new,
                          color: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? AppVar.background
                              : AppVar.primary),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
