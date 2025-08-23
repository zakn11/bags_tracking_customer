import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/controller/theme_controller.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/widgets/home/home_view_documents_icon_widget.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.put(HomeController());

  final List<Meal> meals = [
    Meal(
      name: 'Mediterranean Quinoa Bowl',
      description:
          'Quinoa, feta, olives, tomatoes, cucumber, lemon vinaigrette',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDjG4N9T_wvScqdSowpubDgjzGe5_o2pKTuLYsc8Bc34vWyu3REzgyGIh6Mh47FJrr4D6r3cC4ud-3YL3P_eEUgSjcQPl8v8CiPA597Q0qy9eOUHPPisyPJqHX0Xozuk4Kb9uwC3d8MPQSgRECHFc-BPSf3MFsuLY6N2fUDxd-piX0wp8DYrhK5v-_4o0Jt1gzJMW1a7zT8Az16dU5OiGLDCP_adpuHhhP17MVZ-MAkOOezZNXqmvE92yqeqwm5DpnytDqmZo3FdMoJ',
      isSelected: false,
    ),
    Meal(
      name: 'Grilled Salmon with Asparagus',
      description: 'Salmon fillet, grilled asparagus, lemon herb sauce',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBPC1YIwZubQ1E1D-yLHTRgahm3VgdcOIQ-GPlqsXz74izy55PY1WoqlJXjLGnJn4aoWwAI7bnb5_4vPJuAlLPnQwSOrHtazS_QGvK5VV1RMYFDMBbpHlZrd4p3RBvkOkYsS7wQY7M3IuWsr016CgQWrLG28k-7VuHjQ-FDfrVjqn9IJqaA1n6LXHYqG-IXXQROURqoTwpLQ2oqq7RxdUpEFUnXGVzQNe9yU8rPp-oiJ_t52pk8eWgyWlJbHJTOapcK9mvSPq8RsUjI',
      isSelected: false,
    ),
    Meal(
      name: 'Chicken Stir-Fry with Brown Rice',
      description:
          'Chicken breast, mixed vegetables, brown rice, soy ginger sauce',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCtHciWWFFtBQ0lpLX757Se86XUUYgD9axc7_IbG0YxVyW9QnCKCRPVEP3Y3zSSU_9XsoBLq4KOWvq0gRwZWywAHsH8Pxh2Gq12FfVcy9VHdZiqL5-xvlLdK-sRGCqUvBghD4qSAT6OfiswuBMg7VLB_tPFlES8RfMnPqgfc0JnDcuImbe0kqVh9wkHnlI6yLtQxlwe62jGaeTzY0bORo7cX8d8CJMHF90VjL-z5dtCZCU5xMH3CIUVtzI9QxOG7tDSMt4A1WKwav5k',
      isSelected: false,
    ),
    Meal(
      name: 'Vegan Lentil Soup',
      description: 'Lentils, carrots, celery, onions, vegetable broth, herbs',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCvtu6_c7O-DX8r1QVCCVP3mmM5ZeTwjuRNpPteB5bGW-G04tpw58tnC-saZXXwSXCKXO2plhWv5jMUiSMt45h0yvW3yVZhZ_fUjKWsBSxmL57ne1OWdv8D9_4ZnWZxn6RFqHw4Ym9MjW7lroR3p1UL43m1JSB0EWTb4mqtn3F6aMqvp0jL3jq2cMWs9MgRRLRdshTc6uZ6XRM7RZ-CK1zbHdcX336iVkDr_zetHtoKIlsccIqY_O8rjSIeFMZtHGerqRxvWvABXVvV',
      isSelected: false,
    ),
    Meal(
      name: 'Turkey Meatballs with Zucchini Noodles',
      description:
          'Turkey meatballs, zucchini noodles, marinara sauce, parmesan',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBW-8HhW5BT2uBoG08OwqSZFZAFNyCfv29EwdZSzAfBy7oHCMiE42i_Q4cSBX2xZZPv8YfzncjzEiZ5gY4qQso8pzJ0HoPYhvtKb4L7Nqo-Nf13qEWEgv1855zURn6deUGUvfT2SWeukXt6aST5Md83AylKI5YTltsARifR10PtoQzAZS7QEuCm2pvNqpfbWCmffUB1JXgM1FsIKCNNpJudPyvyIA9LQMu6vHvtNc6HXZvWucCehva2A11jRoraVMDBZGlMcyiO2NFU',
      isSelected: false,
    ),
    Meal(
      name: 'Shrimp Tacos with Avocado Salsa',
      description: 'Shrimp, corn tortillas, avocado salsa, lime',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDvHtQoGKjk7K0dvTVD8uiiqyiH7jUqXZqIyVLAppZt5n3Jm9fjmrMm23kNELa4X8hosk8QgS_a-M6XRjDVpeZsulfNvPZerthOEoCjTecudgmYLmywjgJYfKdKJA7EBPw2J26UH1MijNVHfsdAdMjAdVTb2VjwCB0CNqaaUHcO8h8320_81ZbjRHVNvkAOF6K7KWUtoOOovcEL7jJsu3A9XiXvA7JASbzg3qZHpsP4M6uhl4JUxwFbWzox_Sx5CXQOS1W0sMJPFeRg',
      isSelected: false,
    ),
  ];

  int get selectedMealsCount => meals.where((meal) => meal.isSelected).length;

  void toggleMealSelection(int index) {
    if (meals[index].isSelected) {
      meals[index].isSelected = false;
      setState(() {});
      return;
    }

    if (selectedMealsCount >= 2) {
      CustomToast.errorToast("OPPS...", "You can choose just 2 meals per day");
      return;
    }

    meals[index].isSelected = true;
    setState(() {});
  }
  //Zak delete the initstate
@override
  void initState() {
    super.initState();
    
    // طلب صلاحية الإشعارات (iOS)
    FirebaseMessaging.instance.requestPermission();

    // الحصول على الـ token
    FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");
    });

    // استقبال الإشعار عندما يكون التطبيق مفتوح
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received: ${message.notification?.title}");

      // عرض Pop-up
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(message.notification?.title ?? "No Title"),
          content: Text(message.notification?.body ?? "No Body"),
          actions: [
            TextButton(
              child: Text("OK"),
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
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: AppSizeH.s20),
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      return MealItem(
                        meal: meals[index],
                        onTap: () => toggleMealSelection(index),
                      );
                    },
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
          )
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: AppSizeH.s10,
                top: AppSizeH.s10,
                left: AppSizeW.s4,
                right: AppSizeW.s4),
            child: Text(
              selectedMealsCount > 2
                  ? 'You have selected $selectedMealsCount meals. Please remove one to proceed.'
                  : 'You have selected $selectedMealsCount meals.',
              textAlign: TextAlign.center,
              style: TextStyle(
                // color: AppVar.primary,
                fontSize: AppSizeSp.s14,
                fontWeight: FontWeight.normal,
                height: AppSizeH.s1,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSizeW.s20),
            width: double.infinity,
            // height: AppSizeH.s12,
            child: ElevatedButton(
              onPressed: selectedMealsCount <= 2 ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppVar.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizeR.s12),
                ),
              ),
              child: Text(
                'Confirm Selection',
                style: TextStyle(
                  color: AppVar.seconndTextColor,
                  fontSize: AppSizeSp.s16,
                  letterSpacing: AppSizeSp.s3,
                ),
              ),
            ),
          ),
          SizedBox(height: AppSizeH.s20)
        ],
      ),
    );
  }
}

class Meal {
  final String name;
  final String description;
  final String imageUrl;
  bool isSelected;

  Meal({
    required this.name,
    required this.description,
    required this.imageUrl,
    this.isSelected = false,
  });
}

class MealItem extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  const MealItem({
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
                  child: ElevatedButton.icon(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: meal.isSelected
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
                          meal.isSelected ? 'Added' : 'Add',
                          style: TextStyle(
                            color: meal.isSelected
                                ? AppVar.seconndTextColor
                                : Theme.of(context).disabledColor,
                            fontSize: AppSizeSp.s14,
                            fontWeight: FontWeight.w500,
                            height: AppSizeH.s1,
                          ),
                        ),
                        Icon(
                          meal.isSelected ? Icons.check : Icons.add,
                          size: AppSizeSp.s18,
                          color: meal.isSelected
                              ? AppVar.seconndTextColor
                              : Theme.of(context).disabledColor,
                        ),
                      ],
                    ),
                  ),
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
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
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
