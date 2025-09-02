import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/shared/app_strings.dart';

class CustomSignOutDialog extends StatelessWidget {
  CustomSignOutDialog({super.key});

  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final AppStrings() = AppStrings();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizeR.s10),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(AppSizeW.s20),
        child: SizedBox(
          width: isLandscape ? MediaQuery.sizeOf(context).width * 0.4 : null,
          child: Stack(
            children: [
              Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizeH.s5),
                    Center(
                      child: Text(
                        AppStrings().signOut,
                        style: TextStyle(
                          fontSize: AppSizeSp.s22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizeH.s20),
                    Center(
                      child: Text(
                        AppStrings().doYouWantToLogOut,
                        style: TextStyle(
                          color: Color(0xff878787),
                          fontSize: AppSizeSp.s13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizeH.s20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            homeController.exitSignOutDialog();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: AppSizeH.s10,
                                horizontal: AppSizeW.s20),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffD6D6D6)),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(AppSizeR.s20),
                            ),
                            child: Text(
                              AppStrings().cancel,
                              style: TextStyle(
                                color: AppVar.textColor,
                                fontSize: AppSizeSp.s13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await homeController.logout();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: AppSizeH.s10,
                                horizontal: AppSizeW.s20),
                            decoration: BoxDecoration(
                              color: const Color(0xffFE8C00),
                              borderRadius: BorderRadius.circular(AppSizeR.s20),
                            ),
                            child: Text(
                              AppStrings().logOut,
                              style: TextStyle(
                                color: AppVar.seconndTextColor,
                                fontSize: AppSizeSp.s13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (homeController.isLoading.value)
                      const SizedBox(child: MainLoadingWidget())
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    homeController.exitSignOutDialog();
                  },
                  child: Container(
                      padding: EdgeInsets.all(AppSizeW.s5),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              width: 1, color: const Color(0xffEDEDED)),
                          borderRadius: BorderRadius.circular(AppSizeR.s5)),
                      child: const Icon(
                        size: 18,
                        Icons.close_rounded,
                        color: AppVar.textColor,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
