import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';

class CustomMessageDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  CustomMessageDialog({super.key, required this.title, required this.subtitle});

  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizeR.s20), 
      ),
      backgroundColor: Colors.white, 
      child: Padding(
        padding: EdgeInsets.all(AppSizeW.s20), 
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize
                  .min, 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Row(
                  children: [
                    Text(
                      "${homeController.myInfoModel.value.role.capitalize} name: ",
                      style:  TextStyle(
                        color: Colors.grey,
                        fontSize: AppSizeSp.s14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      title,
                      style:  TextStyle(
                        color: Colors.grey,
                        fontSize: AppSizeSp.s14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizeH.s5), 
                Row(
                  children: [
                    Text(
                      "${homeController.myInfoModel.value.role.capitalize} ID: ",
                      style:  TextStyle(
                        color: Colors.grey,
                        fontSize: AppSizeSp.s14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style:  TextStyle(
                        color: Colors.grey,
                        fontSize: AppSizeSp.s14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: AppSizeH.s40), 

                
                TextFormField(
                  style:  TextStyle(
                    fontSize: AppSizeSp.s14,
                    color: AppVar.textColor,
                  ),
                  onChanged: (value) {
                    if (value != "") {
                      homeController.isTextFildFilled.value = true;
                    } else {
                      homeController.isTextFildFilled.value = false;
                    }
                  },
                  controller: homeController.issueDialogController,
                  maxLines: 9, 
                  decoration: InputDecoration(
                    hintText: 'Enter Your Problem',
                    hintStyle:  TextStyle(
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
                      borderRadius: BorderRadius.circular(
                        AppSizeR.s10,
                      ),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 125, 125, 125),
                          width: 1.0), 
                    ),
                  ),
                ),
                SizedBox(
                    height: AppSizeH.s20), 
                Padding(
                  padding: EdgeInsets.only(bottom: AppSizeH.s10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    
                    children: [
                      Text(
                        DateFormat('EEE, MMM d, y')
                            .format(DateTime.now())
                            .toString(),
                        style:
                            TextStyle(fontSize: AppSizeSp.s11, color: Colors.grey),
                      ),
                      const Spacer(),
                      Obx(
                        () => homeController.isLoading.value
                            ? const SizedBox(child: MainLoadingWidget())
                            :
                            
                            Obx(() {
                                if (homeController.showLottieAnimation.value) {
                                  return Center(
                                    child: SizedBox(
                                      width: AppSizeW.s50,
                                      height: AppSizeH.s50,
                                      child: Lottie.asset(
                                        repeat: false,
                                        fit: BoxFit.fill,
                                        'assets/Lottie/Animation - 1726871315481.json', 
                                      ),
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: !homeController
                                                .isTextFildFilled.value ||
                                            homeController.isLoading.value
                                        ? null 
                                        : () {
                                            homeController.sendToAdmin();
                                          },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: AppSizeH.s5, horizontal: AppSizeW.s10),
                                      decoration: BoxDecoration(
                                        color: homeController.isLoading.value
                                            ? Colors.transparent
                                            : homeController
                                                    .isTextFildFilled.value
                                                ? const Color(0xff3AD189)
                                                : Colors.transparent,
                                        border: !homeController
                                                .isTextFildFilled.value
                                            ? Border.all(color: AppVar.primary)
                                            : null,
                                        borderRadius: BorderRadius.circular(AppSizeR.s10),
                                      ),
                                      child: Text(
                                        "Send to admin",
                                        style: TextStyle(
                                          color: !homeController
                                                  .isTextFildFilled.value
                                              ? AppVar.primary
                                              : AppVar.seconndTextColor,
                                          fontSize: AppSizeSp.s14,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }),
                      ),
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child:  Text(
                  "Your Problem",
                  style: TextStyle(
                    fontSize: AppSizeSp.s12,
                    fontWeight: FontWeight.bold,
                    color: AppVar.textColor,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  homeController.exitMessageDialog();
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            width: 1, color: const Color(0xffEDEDED)),
                        borderRadius: BorderRadius.circular(AppSizeR.s5)),
                    child: const Icon(
                      Icons.close_rounded,
                      color: AppVar.textColor,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
