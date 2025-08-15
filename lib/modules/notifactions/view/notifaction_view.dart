import 'package:flutter/material.dart';
import 'package:tracking_system_app/modules/home/view/home_view.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class NotifactionView extends StatelessWidget {
  const NotifactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppVar.primary,
        title: Center(
          child: Text(
            'Notifications',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSizeSp.s18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: AppVar.seconndTextColor,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: AppSizeH.s35,
              color: AppVar.primary,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizeW.s20,
                vertical: AppSizeH.s40,
              ),
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      SizedBox(height: AppSizeH.s20),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          width: AppSizeW.s48,
                          height: AppSizeH.s48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F2EC),
                            borderRadius: BorderRadius.circular(AppSizeR.s8),
                          ),
                          child: Icon(
                            index == 0
                                ? Icons.notifications
                                : Icons.set_meal_sharp,
                            color: const Color(0xFF0E1A13),
                            size: AppSizeSp.s24,
                          ),
                        ),
                        SizedBox(width: AppSizeW.s16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // 'Your order is on way',
                              'Your subscription is ending soon',
                              style: TextStyle(
                                fontSize: AppSizeSp.s16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              //  '2024-2-3',

                              '3 days left',
                              style: TextStyle(
                                color: AppVar.primary,
                                fontSize: AppSizeSp.s14,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  })),
        ],
      ),
    );
  }
}
