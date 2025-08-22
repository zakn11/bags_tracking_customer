import 'package:flutter/material.dart';
import 'package:tracking_system_app/modules/home/view/home_view.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor = isDark ? Colors.black : Colors.white;
    Color cardColor = isDark ? Colors.grey[850]! : Colors.white;
    Color textColor = isDark ? Colors.white : Colors.black;
    Color primaryColor = AppVar.primary;
    Color statusProcessing = isDark ? Colors.orangeAccent : Colors.orange;
    Color statusDelivered = isDark ? Colors.greenAccent : Colors.green;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
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
              height: AppSizeH.s50,
              color: primaryColor,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(AppSizeW.s16),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    color: cardColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizeR.s16),
                    ),
                    margin: EdgeInsets.only(bottom: AppSizeH.s16),
                    child: Padding(
                      padding: EdgeInsets.all(AppSizeW.s12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order #${index + 1}',
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
                                  color: index.isEven
                                      ? statusProcessing.withOpacity(0.2)
                                      : statusDelivered.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  index.isEven ? 'Processing' : 'Delivered',
                                  style: TextStyle(
                                    fontSize: AppSizeSp.s12,
                                    color: index.isEven
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
                            'Meals: 2 items\nDelivery Address: Dubai',
                            style: TextStyle(
                              fontSize: AppSizeSp.s14,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: AppSizeH.s12),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
