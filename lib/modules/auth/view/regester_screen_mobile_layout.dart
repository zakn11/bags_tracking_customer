import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_system_app/modules/auth/controller/register_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/auth/regester_form_widget.dart';

class RegesterScreenMobileLayout extends GetView<RegisterController> {
  const RegesterScreenMobileLayout(BuildContext context, {super.key});

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
                      : AppVar.primary,
          body: OrientationBuilder(builder: (context, orientation) {
            final screenWidth = MediaQuery.sizeOf(context).width;
            final screenHeight = MediaQuery.sizeOf(context).height;
            final isTablet =
                screenWidth > 600; 
            final isLandscape =
                MediaQuery.of(context).orientation == Orientation.landscape;
            if (controller.isWaitAdminApproved.value) {
              return WaitingAdminApprovedMobileWidget(
                  controller: controller, isLandscape: isLandscape);
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizeW.s40,
                    vertical: isLandscape
                        ? AppSizeH.s20
                        : screenWidth <= 400 && screenHeight < 700
                            ? AppSizeH.s0
                            : screenWidth * 0.1),
                child: Obx(
                  () => Opacity(
                    opacity: controller.isWaitAdminApproved.value ? 0 : 1,
                    child: RegesterFormWidget(
                      screenHeight:screenHeight,
                      controller: controller,
                      isLandscape: isLandscape,
                      isTablet: isTablet,
                      screenWidth: screenWidth,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class WaitingAdminApprovedMobileWidget extends StatelessWidget {
  const WaitingAdminApprovedMobileWidget({
    super.key,
    required this.controller,
    required this.isLandscape,
  });

  final RegisterController controller;
  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isWaitAdminApproved.value) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!isLandscape)
              ClipRRect(
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
            SizedBox(height: AppSizeH.s20),
            Center(
              child: LottieBuilder.asset(
                repeat: false,
                "assets/Lottie/Animation - 1726871315481.json",
                width: AppSizeW.s200,
                height: AppSizeH.s200,
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
              padding: EdgeInsets.symmetric(vertical: AppSizeH.s5, horizontal: AppSizeW.s15),
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
        );
      } else {
        return Container();
      }
    });
  }
}
