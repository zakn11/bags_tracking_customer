import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/shared/app_strings.dart';

class CustomMessageDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  CustomMessageDialog({super.key, required this.title, required this.subtitle});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor = isDark ? Colors.grey[900]! : Colors.white;
    final AppStrings() = AppStrings();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizeR.s20),
      ),
      backgroundColor: backgroundColor,
      child: Padding(
        padding: EdgeInsets.all(AppSizeW.s20),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey,
                        fontSize: AppSizeSp.s14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizeH.s5),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.grey,
                          fontSize: AppSizeSp.s14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizeH.s40),
                TextFormField(
                  style: TextStyle(
                    fontSize: AppSizeSp.s14,
                    color: isDark ? AppVar.seconndTextColor : AppVar.textColor,
                  ),
                  onChanged: (value) {
                    homeController.isTextFildFilled.value = value.isNotEmpty;
                  },
                  controller: homeController.issueDialogController,
                  maxLines: 9,
                  decoration: InputDecoration(
                    hintText: AppStrings().enterYourProblem,
                    hintStyle: TextStyle(
                      color: const Color(0xffBFBFBF),
                      fontSize: AppSizeSp.s12,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizeR.s10),
                      borderSide:
                          const BorderSide(color: AppVar.textColor, width: 2.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizeR.s10),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizeR.s10),
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizeR.s10),
                      borderSide: BorderSide(
                        color: isDark ? Colors.white54 : Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSizeH.s20),
                Padding(
                  padding: EdgeInsets.only(bottom: AppSizeH.s10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEE, MMM d, y')
                            .format(DateTime.now())
                            .toString(),
                        style: TextStyle(
                          fontSize: AppSizeSp.s11,
                          color: isDark ? Colors.white54 : Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Obx(() {
                        if (homeController.isLoading.value) {
                          return const MainLoadingWidget();
                        } else if (homeController.showLottieAnimation.value) {
                          return SizedBox(
                            width: AppSizeW.s50,
                            height: AppSizeH.s50,
                            child: Lottie.asset(
                              'assets/Lottie/Animation - 1726871315481.json',
                              repeat: false,
                              fit: BoxFit.fill,
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: !homeController.isTextFildFilled.value
                                ? null
                                : () {
                                    homeController.sendToAdmin();
                                  },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppSizeH.s5,
                                  horizontal: AppSizeW.s10),
                              decoration: BoxDecoration(
                                color: homeController.isTextFildFilled.value
                                    ? const Color(0xff3AD189)
                                    : Colors.transparent,
                                border: !homeController.isTextFildFilled.value
                                    ? Border.all(color: AppVar.primary)
                                    : null,
                                borderRadius:
                                    BorderRadius.circular(AppSizeR.s10),
                              ),
                              child: Text(
                                AppStrings().sendToAdmin,
                                style: TextStyle(
                                  color: homeController.isTextFildFilled.value
                                      ? AppVar.seconndTextColor
                                      : AppVar.primary,
                                  fontSize: AppSizeSp.s10,
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: AppSizeW.s20,
              top: AppSizeH.s75,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppSizeW.s5),
                color: backgroundColor,
                child: Text(
                  AppStrings().yourProblem,
                  style: TextStyle(
                    fontSize: AppSizeSp.s12,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppVar.seconndTextColor : AppVar.textColor,
                  ),
                ),
              ),
            ),
            Positioned(
              right: context.locale.languageCode != 'ar' ? 0 : null,
              left: context.locale.languageCode == 'ar' ? 0 : null,
              top: 0,
              child: GestureDetector(
                onTap: homeController.exitMessageDialog,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        width: 1,
                        color:
                            isDark ? Colors.white54 : const Color(0xffEDEDED)),
                    borderRadius: BorderRadius.circular(AppSizeR.s5),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: isDark ? AppVar.seconndTextColor : AppVar.textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
