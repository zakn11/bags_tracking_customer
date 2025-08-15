import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_system_app/controller/life_cycle_controller.dart';
import 'package:tracking_system_app/controller/theme_controller.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/shared/shared.dart';
import 'package:tracking_system_app/style/app_var.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences _pref = await SharedPreferences.getInstance();
  sharedLoginToken = _pref.getString('token');
  if (sharedLoginToken != null) {
    $.token1 = sharedLoginToken;
    $.role = _pref.getString('role');
  }
  
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

bool get isTablet {
  final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
  final logicalShortestSide =
      firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
  return logicalShortestSide > 600;
}

  @override
  Widget build(BuildContext context) {
    Get.put(LifecycleController());
    return ScreenUtilInit(
      designSize: isTablet ? const Size(1194, 834) : const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Traking System',
          theme: AppVar.lightTheme,
          darkTheme: AppVar.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: sharedLoginToken != null
              ? Routes.HOME
              : Routes.SPLASH_SCREEN, 
          getPages: AppPages.routes,
        );
      }
    );
  }
}
