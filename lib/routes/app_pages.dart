import 'package:get/get.dart';
import 'package:tracking_system_app/modules/auth/binding/forget_password_binding.dart';
import 'package:tracking_system_app/modules/auth/binding/login_binding.dart';
import 'package:tracking_system_app/modules/auth/view/login_view.dart';
import 'package:tracking_system_app/modules/auth/view/otp/forget_password_page.dart';
import 'package:tracking_system_app/modules/home/binding/home_binding.dart';
import 'package:tracking_system_app/modules/main_navigation/views/main_navigation.dart';
import 'package:tracking_system_app/modules/splash/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const MainNavigation(),
      // page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () =>  ForgetPasswordPage(),
      binding: ForgetPasswordBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(name: _Paths.SPLASH_SCREEN, page: () => const SplashScreen()),
    //     GetPage(
    //   name: _Paths.MEAL_DETAILS,
    //   page: () => const MealDetailsView(),
    //   transition: Transition.rightToLeft,
    // ),

  ];
}
