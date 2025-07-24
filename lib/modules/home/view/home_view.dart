import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/widgets/home/home_view_documents_icon_widget.dart';

class HomeView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFA),
      body: SafeArea(
        child: Column(
          children: [
            //1
            Padding(
              padding: EdgeInsets.all(AppSizeW.s16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Expanded(
                    child: Center(
                      child: Text(
                        'Home',
                        style: TextStyle(
                          color: const Color(0xFF0E1A13),
                          fontSize: AppSizeSp.s18,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          letterSpacing: -0.015,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppSizeW.s48,
                    child: IconButton(
                      icon: const Icon(Icons.person_outline, size: 24),
                      color: const Color(0xFF0E1A13),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            //2
             Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizeW.s16, vertical: AppSizeH.s8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Today's Meals",
                  style: TextStyle(
                    color:const Color(0xFF0E1A13),
                    fontSize: AppSizeSp.s18,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    letterSpacing: -0.015,
                  ),
                ),
              ),
            ),

            //3
            Padding(
              padding: EdgeInsets.all(AppSizeW.s16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizeR.s12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            "Lunch",
                            style: TextStyle(
                              color:const Color(0xFF51946C),
                              fontSize: AppSizeSp.s14,
                              height: 1.5,
                            ),
                          ),
                           SizedBox(height: AppSizeH.s4),
                           Text(
                            "Quinoa Salad with Grilled Chicken",
                            style: TextStyle(
                              color:const Color(0xFF0E1A13),
                              fontSize: AppSizeSp.s16,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                           Text(
                            "A light and refreshing salad with protein-packed chicken.",
                            style: TextStyle(
                              color: const Color(0xFF51946C),
                              fontSize: AppSizeSp.s14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                     SizedBox(width: AppSizeW.s16),
                    Expanded(
                      flex: 1,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSizeR.s12),
                          child: Image.network(
                            "https://lh3.googleusercontent.com/aida-public/AB6AXuAehA5qWcdKTg2tMP3azfFIPswjVS55eO9NLzz2Bb165LLuiufVASHMq3PJnc2SQ_4Cj_TjJByBGrdT4eJ8v2mXdsyaLZdiWEkoJ1-szlctaFB_sFwjBhl2p4F-30Yg8YICRjWR7rwPXhwvj6fasQGQMnntZBiRTjozz87Q_mV9KE6PdCNkAcYGgHefqVwRHEZlRynKEP4dG9zKsvYnTq-Uf9tGkWhdfJrryDrURBDCXDBzOt8dFNO8R8SIFPPQh1wxRdta5GTMyWmM",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 4
            Padding(
              padding: EdgeInsets.all(AppSizeW.s16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizeR.s12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            "Dinner",
                            style: TextStyle(
                              color:const Color(0xFF51946C),
                              fontSize: AppSizeSp.s14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                           Text(
                            "Salmon with Roasted Vegetables",
                            style: TextStyle(
                              color:const Color(0xFF0E1A13),
                              fontSize: AppSizeSp.s16,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                           Text(
                            "A healthy and delicious meal with omega-3 rich salmon.",
                            style: TextStyle(
                              color:const Color(0xFF51946C),
                              fontSize: AppSizeSp.s14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSizeR.s12),
                          child: Image.network(
                            "https://lh3.googleusercontent.com/aida-public/AB6AXuApWOlqOKU4xeiTLDxOWMFiLShaNHcl0XuVzrXBLFTlNjRyJw0fzwMP69S-x1A_N7Uvil0zlU2lbJJEczSE2lbvX88yOCuFcw23nOH1SfCap5qzhYF1ztIhbswHM0tZxTT2LRJ4ZDtHTpGchXEUOt_8ulNZVuw2bGCgW-WTKFbd0TjzT9jYz1bwrR-x4Y5uJbms2SpKmpG1x8kwp9oLR9PgVhzXFEQd8iitw7qS83DgtkINgyMk0_ROBX_rYlNWOd_BirqN5iNEYSfi",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // 5
            Padding(
              padding:
                   EdgeInsets.symmetric(horizontal: AppSizeW.s16, vertical: AppSizeH.s12),
              child: SizedBox(
                width: double.infinity,
                height: AppSizeH.s48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF38E07B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizeR.s12),
                    ),
                  ),
                  onPressed: () {},
                  child:  Text(
                    "Start Meal Selection",
                    style: TextStyle(
                      color:const Color(0xFF0E1A13),
                      fontSize: AppSizeSp.s16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.015,
                    ),
                  ),
                ),
              ),
            ),

            Container(
              height: AppSizeH.s20,
              color: const Color(0xFFF8FBFA),
            ),
          ],
        ),
      ),
    );
  }
}
