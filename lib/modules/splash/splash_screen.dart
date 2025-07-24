import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/splash/controller/splash_controller.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: const Color(0xff146635),
      body: Center(
        child: GetBuilder<SplashController>(
          builder: (_) => AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, child) {
              return Opacity(
                opacity: controller.opacityAnimation.value,
                child: Transform.scale(
                  scale: controller.scaleAnimation.value, 
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizeR.s20),
                    child: SizedBox(
                      width: AppSizeW.s310,
                      height: AppSizeH.s310,
                      child: SvgPicture.asset(
                        "assets/images/Logo-1.svg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
