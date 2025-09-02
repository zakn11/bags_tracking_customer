import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_system_app/controller/theme_controller.dart';
import 'package:tracking_system_app/model/get_all_meals_model.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/modules/home/view/meal_details_view.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/general/costume_TextField_widget.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/shared/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.put(HomeController());
  final AppStrings appStrings = AppStrings();

  //Zak delete the initstate
  @override
  void initState() {
    super.initState();

    // طلب صلاحية الإشعارات (iOS)
    FirebaseMessaging.instance.requestPermission();

    // الحصول على الـ token
    FirebaseMessaging.instance.getToken().then((token) {
      if (token != null) {
        homeController.sendFcmToken(fcmToken: token);
      }
      print("FCM Token: $token");
    });

    // استقبال الإشعار عندما يكون التطبيق مفتوح
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received: ${message.notification?.title}");

      // عرض Pop-up
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(message.notification?.title ?? appStrings.noTitle),
          content: Text(message.notification?.body ?? appStrings.noBody),
          actions: [
            TextButton(
              child: Text(appStrings.ok),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    });

    // عند فتح التطبيق من الإشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("App opened from notification: ${message.data}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppVar.primary,
        leading: IconButton(
          onPressed: () {
            homeController.showCustomSignOutDialog(context);
          },
          icon: Icon(
            size: AppSizeW.s18,
            Icons.logout,
            color: AppVar.seconndTextColor,
          ),
        ),
        title: Center(
          child: Text(
            appStrings.selectMeals,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSizeSp.s18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: AppVar.seconndTextColor,
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.language,
              color: AppVar.seconndTextColor,
            ),
            onSelected: (String value) {
              switch (value) {
                case 'en':
                  context.setLocale(const Locale('en'));
                  break;
                case 'ar':
                  context.setLocale(const Locale('ar'));
                  break;
                case 'fr':
                  context.setLocale(const Locale('fr'));
                  break;
              }
              Get.updateLocale(Locale(value));
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'en',
                child: Text(AppStrings().english),
              ),
              PopupMenuItem<String>(
                value: 'ar',
                child: Text(AppStrings().arabic),
              ),
              PopupMenuItem<String>(
                value: 'fr',
                child: Text(AppStrings().french),
              ),
            ],
          ),
          Obx(() => GestureDetector(
                onTap: themeController.toggleTheme,
                child: Icon(
                  themeController.isDarkMode.value
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: AppVar.seconndTextColor,
                ),
              )),
          IconButton(
            onPressed: () {
              homeController.showCustomMessageDialog(context, homeController);
            },
            icon: Icon(
              size: AppSizeW.s18,
              Icons.messenger_outline,
              color: AppVar.seconndTextColor,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(
            child: MainLoadingWidget(),
          );
        }
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizeW.s20, vertical: AppSizeH.s20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: AppSizeH.s20),
                    CustomeTextFormField(
                      title: "",
                      onChanged: (value) {
                        homeController.searchQuery.value = value;
                      },
                      hintText: appStrings.searchMeals,
                      prefixIcon: const Icon(Icons.search),
                      inputType: TextInputType.text,
                      controller: TextEditingController(),
                      validator: null,
                    ),
                    SizedBox(height: AppSizeH.s20),
                    Text(
                      appStrings.chooseUpTo2Meals,
                      style: TextStyle(
                        fontSize: AppSizeSp.s15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppSizeH.s20),
                    Obx(() {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: AppSizeH.s20),
                        itemCount: homeController.filteredMeals.length,
                        itemBuilder: (context, index) {
                          final meal = homeController.filteredMeals[index];

                          return Column(
                            children: [
                              MealItem(
                                meal: meal,
                                onTap: () {
                                  homeController.toggleMealSelection(
                                    homeController
                                        .getAllMealsModel.value.meals[index].id,
                                  );
                                },
                              ),
                              if (index !=
                                  homeController
                                          .getAllMealsModel.value.meals.length -
                                      1)
                                ...[]
                            ],
                          );
                        },
                      );
                    }),
                    SizedBox(height: AppSizeH.s80),
                  ],
                ),
              ),
            ),
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: AppSizeH.s35,
                color: AppVar.primary,
              ),
            ),
          ],
        );
      }),
      bottomSheet: Obx(() {
        return homeController.isLoading.value
            ? const SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: AppSizeW.s4, right: AppSizeW.s4),
                    child: Text(
                      "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppSizeSp.s14,
                        fontWeight: FontWeight.normal,
                        height: AppSizeH.s1,
                      ),
                    ),
                  ),
                  Obx(() {
                    Widget child;

                    if (homeController.isConfirmitionLoading.value) {
                      child = const MainLoadingWidget();
                    } else if (homeController
                        .showLottieAnimationForConfirmation.value) {
                      child = Center(
                        child: SizedBox(
                          width: AppSizeW.s50,
                          height: AppSizeH.s50,
                          child: Lottie.asset(
                            'assets/Lottie/Animation - 1726871315481.json',
                            repeat: false,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    } else {
                      child = Text(
                        appStrings.confirmSelection,
                        style: TextStyle(
                          color: AppVar.seconndTextColor,
                          fontSize: AppSizeSp.s16,
                          letterSpacing: AppSizeSp.s3,
                        ),
                      );
                    }

                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: AppSizeW.s20),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: homeController.isConfirmitionLoading.value
                            ? () {}
                            : () {
                                homeController.confirmSelectedMeals();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppVar.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizeR.s12),
                          ),
                        ),
                        child: child,
                      ),
                    );
                  }),
                  SizedBox(height: AppSizeH.s20),
                ],
              );
      }),
    );
  }
}

class MealItem extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final AppStrings appStrings = AppStrings();

  final MealModel meal;
  final VoidCallback onTap;

  MealItem({
    super.key,
    required this.meal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    Color cardColor = isDark ? Colors.grey[850]! : Colors.white;
    return Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizeR.s10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(AppSizeW.s6),
            width: AppSizeW.s50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizeR.s10),
                    bottomRight: Radius.circular(AppSizeR.s10)),
                color: AppVar.warning),
            child: Text(
              meal.id.toString(),
              style: const TextStyle(
                color: AppVar.seconndTextColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: AppSizeH.s10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizeW.s10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: TextStyle(
                          fontSize: AppSizeSp.s16,
                          fontWeight: FontWeight.bold,
                          height: AppSizeH.s1,
                        ),
                      ),
                      SizedBox(height: AppSizeH.s10),
                      Text(
                        meal.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: AppVar.primary,
                          fontSize: AppSizeSp.s14,
                          fontWeight: FontWeight.normal,
                          height: AppSizeH.s1,
                        ),
                      ),
                      SizedBox(height: AppSizeH.s15),
                    ],
                  ),
                ),
                SizedBox(width: AppSizeW.s4),
                Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizeR.s12),
                      child: meal.imgs.isNotEmpty
                          ? Image.network(
                              "http://10.0.2.2:8000/${meal.imgs[0]}",
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image.asset("assets/images/icon.png");
                              },
                              fit: BoxFit.cover,
                            )
                          : Image.asset("assets/images/icon.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSizeH.s10),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSizeW.s10, vertical: AppSizeH.s5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: AppSizeH.s30,
                    child: Obx(() {
                      final isSelected =
                          homeController.selectedMealIds.contains(meal.id);
                      return ElevatedButton.icon(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected
                              ? AppVar.primarySoft
                              : Theme.of(context).splashColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizeR.s8),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: AppSizeW.s4),
                          minimumSize: Size(AppSizeW.s80, AppSizeH.s0),
                        ),
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isSelected ? appStrings.added : appStrings.add,
                              style: TextStyle(
                                color: isSelected
                                    ? AppVar.seconndTextColor
                                    : Theme.of(context).disabledColor,
                                fontSize: AppSizeSp.s14,
                                fontWeight: FontWeight.w500,
                                height: AppSizeH.s1,
                              ),
                            ),
                            Icon(
                              isSelected ? Icons.check : Icons.add,
                              size: AppSizeSp.s18,
                              color: isSelected
                                  ? AppVar.seconndTextColor
                                  : Theme.of(context).disabledColor,
                            ),
                          ],
                        ),
                      );
                    })),
                TextButton(
                    onPressed: () {
                      Get.to(
                        () => MealDetailsView(meal: meal),
                      );
                    },
                    child: Row(
                      spacing: AppSizeH.s2,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          appStrings.details,
                          style: TextStyle(
                              letterSpacing: 1,
                              decoration: TextDecoration.underline,
                              color: AppVar.primary,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          size: AppSizeW.s11,
                          Icons.arrow_forward_ios_rounded,
                          color: AppVar.primary,
                        ),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 20);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 40);
    var secondEndPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
