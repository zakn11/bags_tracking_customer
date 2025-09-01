import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/view/home_view.dart';
import 'package:tracking_system_app/modules/orders/controller/orders_controller.dart';
import 'package:tracking_system_app/modules/profile/controller/profile_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';

class OrdersView extends StatelessWidget {
  OrdersView({super.key});
  final OrdersController ordersController = Get.put(OrdersController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor = isDark ? Colors.black : Colors.white;
    Color cardColor = isDark ? Colors.grey[850]! : Colors.white;
    Color textColor = isDark ? Colors.white : Colors.black;
    Color statusProcessing = isDark ? Colors.orangeAccent : Colors.orange;
    Color statusDelivered = isDark ? Colors.greenAccent : Colors.green;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppVar.primary,
        elevation: 0,
        title: Text(
          'My Orders',
          style: TextStyle(
            fontSize: AppSizeSp.s18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: AppSizeH.s35,
              color: AppVar.primary,
            ),
          ),
          Obx(() {
            if (ordersController.isLoading.value) {
              return const Center(
                child: MainLoadingWidget(),
              );
            } else {
              if (ordersController.myOrderResponseModel.isNotEmpty) {
                final myOrdersList = ordersController.myOrderResponseModel;
                return Expanded(
                  child: RefreshIndicator(
                    color: AppVar.primary,
                    onRefresh: () async {
                      await ordersController.initialize();
                    },
                    child: Padding(
                        padding: EdgeInsets.all(AppSizeW.s16),
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: myOrdersList.length,
                          itemBuilder: (context, index) {
                            final reversedIndex =
                                myOrdersList.length - 1 - index;
                            final order = myOrdersList[reversedIndex];

                            return Card(
                              color: cardColor,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSizeR.s5),
                              ),
                              margin: EdgeInsets.only(bottom: AppSizeH.s16),
                              child: Padding(
                                padding: EdgeInsets.all(AppSizeW.s12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Order #${order.id}',
                                          style: TextStyle(
                                            fontSize: AppSizeSp.s16,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: AppSizeW.s12,
                                            vertical: AppSizeH.s4,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                order.status == "In preparation"
                                                    ? statusProcessing
                                                        .withValues(alpha: 0.2)
                                                    : statusDelivered
                                                        .withValues(alpha: 0.2),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            order.status,
                                            style: TextStyle(
                                              fontSize: AppSizeSp.s12,
                                              color: order.status ==
                                                      "In preparation"
                                                  ? statusProcessing
                                                  : statusDelivered,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: AppSizeH.s8),
                                    Text(
                                      'Meals: ${order.meal1} | ${order.meal2}\n${profileController.getCustomerInfo.value.address != "" ? "Delivery Address: ${profileController.getCustomerInfo.value.address}" : ""}',
                                      style: TextStyle(
                                        fontSize: AppSizeSp.s14,
                                        color: textColor,
                                      ),
                                    ),
                                    SizedBox(height: AppSizeH.s12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          order.orderDate,
                                          style: TextStyle(
                                            fontSize: AppSizeSp.s14,
                                            color: AppVar.primary,
                                          ),
                                        ),
                                        if (order.status == "In preparation")
                                          Obx(
                                             () {
                                              if(ordersController.isDeleteLoading.value){
                                                return CircularProgressIndicator(color: AppVar.primary,strokeWidth: 2);
                                              }
                                              return IconButton(
                                                  onPressed: () {
                                                    ordersController.deleteOrder(id: order.id);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ));
                                            }
                                          )
                                      ],
                                    ),
                                    SizedBox(height: AppSizeH.s12),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                );
              } else {
                return Center(
                  child: SvgPicture.asset(
                    'assets/images/empty.svg',
                    // ignore: deprecated_member_use
                    color: AppVar.primary,
                    width: AppSizeW.s100,
                    height: AppSizeH.s100,
                  ),
                );
              }
            }
          }),
        ],
      ),
    );
  }
}
