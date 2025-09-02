import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/modules/home/view/home_view.dart';
import 'package:tracking_system_app/modules/notifactions/view/notifaction_view.dart';
import 'package:tracking_system_app/modules/orders/view/orders_view.dart';
import 'package:tracking_system_app/modules/profile/view/profile_view.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/shared/app_strings.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    OrdersView(),
    const NotifactionView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      final HomeController homeController = Get.put(HomeController());
      homeController.initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppStrings() = AppStrings();

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(),
        padding: EdgeInsets.fromLTRB(
            AppSizeW.s16, AppSizeH.s8, AppSizeW.s16, AppSizeH.s12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => _onItemTapped(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home_filled,
                    size: 24,
                    color: _selectedIndex != 0
                        ? Theme.of(context).hintColor
                        : const Color(0xFF51946C),
                  ),
                  SizedBox(height: AppSizeH.s4),
                  Text(
                    AppStrings().home,
                    style: TextStyle(
                      color: _selectedIndex != 0
                          ? Theme.of(context).hintColor
                          : const Color(0xFF51946C),
                      fontSize: AppSizeSp.s12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.015,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.emoji_food_beverage_outlined,
                    size: 24,
                    color: _selectedIndex != 1
                        ? Theme.of(context).hintColor
                        : const Color(0xFF51946C),
                  ),
                  SizedBox(height: AppSizeH.s4),
                  Text(
                    AppStrings().orders,
                    style: TextStyle(
                      color: _selectedIndex != 1
                          ? Theme.of(context).hintColor
                          : const Color(0xFF51946C),
                      fontSize: AppSizeSp.s12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.015,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications,
                    size: 24,
                    color: _selectedIndex != 2
                        ? Theme.of(context).hintColor
                        : const Color(0xFF51946C),
                  ),
                  SizedBox(height: AppSizeH.s4),
                  Text(
                    AppStrings().notifications,
                    style: TextStyle(
                      color: _selectedIndex != 2
                          ? Theme.of(context).hintColor
                          : const Color(0xFF51946C),
                      fontSize: AppSizeSp.s12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.015,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.contact_page_rounded,
                    size: 24,
                    color: _selectedIndex != 3
                        ? Theme.of(context).hintColor
                        : const Color(0xFF51946C),
                  ),
                  SizedBox(height: AppSizeH.s4),
                  Text(
                    AppStrings().profile,
                    style: TextStyle(
                      color: _selectedIndex != 3
                          ? Theme.of(context).hintColor
                          : const Color(0xFF51946C),
                      fontSize: AppSizeSp.s12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.015,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
