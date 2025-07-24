import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/home/customers_list_widget.dart';

import '../../style/app_var.dart';

class HomeViewCustomersIconWidget extends StatelessWidget {
  const HomeViewCustomersIconWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final isTaplet = MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.height > 800;
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged.map((list) => list.first),
        builder: (context, snapshot) {
          return snapshot.data == ConnectivityResult.none
              ? Obx(() {
                  return Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 100),
                        child: GestureDetector(
                          /*to leave the interface when i click anywhere*/
                          onTap: () {
                            controller.isDocumentsIconPressed.value = false;
                          },
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: controller.isDocumentsIconPressed.value
                                ? 0.9
                                : 0.0,
                            child: Container(
                              width: controller.isDocumentsIconPressed.value
                                  ? MediaQuery.sizeOf(context).width
                                  : 0,
                              height: controller.isDocumentsIconPressed.value
                                  ? MediaQuery.sizeOf(context).height
                                  : 0,
                              color: const Color(0xffD4D4D4),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            // Get.back();
                            controller.isDocumentsIconPressed.value =
                                !controller.isDocumentsIconPressed.value;
                          },
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                      if (controller.isDocumentsIconPressed.value)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSizeH.s20),
                          child: snapshot.data == ConnectivityResult.none
                              ? _noInternetWidget(isTaplet)
                              : CustomersListWidget(controller: controller),
                        ),
                    ],
                  );
                })
              : SingleChildScrollView(
                  child: Obx(() {
                    return Stack(
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 100),
                          child: GestureDetector(
                            /*to leave the interface when i click anywhere*/
                            onTap: () {
                              controller.isDocumentsIconPressed.value = false;
                            },
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: controller.isDocumentsIconPressed.value
                                  ? 0.9
                                  : 0.0,
                              child: Container(
                                width: controller.isDocumentsIconPressed.value
                                    ? MediaQuery.sizeOf(context).width
                                    : 0,
                                height: controller.isDocumentsIconPressed.value
                                    ? MediaQuery.sizeOf(context).height
                                    : 0,
                                color: const Color(0xffD4D4D4),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              // Get.back();
                              controller.isDocumentsIconPressed.value =
                                  !controller.isDocumentsIconPressed.value;
                            },
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                        if (controller.isDocumentsIconPressed.value)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: CustomersListWidget(controller: controller),
                          ),
                      ],
                    );
                  }),
                );
        });
  }

  Widget _noInternetWidget(isTaplet) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Image(
            image: const AssetImage("assets/images/no-internet.png"),
            width: AppSizeW.s150,
            height: AppSizeH.s150,
          ),
          SizedBox(height: AppSizeH.s10),
          Text(
            "Connect to Internet and try again",
            style: TextStyle(
              fontSize: isTaplet ? AppSizeSp.s33 : AppSizeSp.s16,
              fontFamily: "ABeeZee",
              color: AppVar.primary,
              decoration: TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }
}
