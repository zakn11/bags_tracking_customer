import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_system_app/controller/theme_controller.dart';
import 'package:tracking_system_app/model/get_all_meals_model.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.put(HomeController());



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
            'Select Meals',
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
      body: Obx(
         () {
          if(homeController.isLoading.value){
                return const Center(child: MainLoadingWidget(),);
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
                      Text(
                        'Choose up to 2 meals per delivery day',
                        style: TextStyle(
                          fontSize: AppSizeSp.s18,
                          fontWeight: FontWeight.bold,
                          // height: AppSizeH.s1,
                          letterSpacing: AppSizeW.s2,
                        ),
                      ),
                      SizedBox(height: AppSizeH.s20),
                      Obx(
                         () {
                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: AppSizeH.s20),
                            itemCount: homeController.getAllMealsModel.value.meals.length,
                            itemBuilder: (context, index) {
                              return MealItem(
  meal: homeController.getAllMealsModel.value.meals[index],
  onTap: () {
    homeController.toggleMealSelection(
      homeController.getAllMealsModel.value.meals[index].id,
    );
  },
);

                            },
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: AppSizeH.s10,
                top: AppSizeH.s50,
                child: Container(
                  width: AppSizeW.s60,
                  height: AppSizeH.s60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: Obx(() => GestureDetector(
                        onTap: themeController.toggleTheme,
                        child: Icon(
                          themeController.isDarkMode.value
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: AppVar.seconndTextColor,
                        ),
                      )),
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
        }
      ),
      bottomSheet:Obx(
         () {
          return homeController.isLoading.value?const SizedBox.shrink():  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: AppSizeH.s10,
                    top: AppSizeH.s10,
                    left: AppSizeW.s4,
                    right: AppSizeW.s4),
                child: Text(
                  "",
                  // selectedMealsCount > 2
                  //     ? 'You have selected $selectedMealsCount meals. Please remove one to proceed.'
                  //     : 'You have selected $selectedMealsCount meals.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // color: AppVar.primary,
                    fontSize: AppSizeSp.s14,
                    fontWeight: FontWeight.normal,
                    height: AppSizeH.s1,
                  ),
                ),
              ),
             Obx(() {
  Widget child;

  if (homeController.isConfirmitionLoading.value) {
    // ⏳ حالة الـ Loading
    child = const MainLoadingWidget();
  } else if (homeController.showLottieAnimationForConfirmation.value) {
    // 🎉 حالة الـ Lottie Animation
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
    // 🔘 الحالة العادية (زر تأكيد)
    child = Text(
      'Confirm Selection',
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
        }
      ),
    );
  }
}

class MealItem extends StatelessWidget {
      final HomeController homeController = Get.find<HomeController>();

  final MealModel meal;
  final VoidCallback onTap;

   MealItem({
    super.key,
    required this.meal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizeR.s12),
      ),
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
                  style: TextStyle(
                    color: AppVar.primary,
                    fontSize: AppSizeSp.s14,
                    fontWeight: FontWeight.normal,
                    height: AppSizeH.s1,
                  ),
                ),
                SizedBox(height: AppSizeH.s15),
                SizedBox(
                  height: AppSizeH.s30,
                  child: Obx(() {
  final isSelected = homeController.selectedMealIds.contains(meal.id);
  return ElevatedButton.icon(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: isSelected
          ? AppVar.primarySoft
          : Theme.of(context).splashColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizeR.s8),
      ),
      padding: EdgeInsets.symmetric(horizontal: AppSizeW.s4),
      minimumSize: Size(AppSizeW.s80, AppSizeH.s0),
    ),
    label: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isSelected ? 'Added' : 'Add',
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
})

                ),
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
                child: meal.imgs.isNotEmpty? Image.network(
                  meal.imgs[0],
                  fit: BoxFit.cover,
                ):Image.asset("assets/images/icon.png"),
              ),
            ),
          ),
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
