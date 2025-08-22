import 'package:flutter/material.dart';
import 'package:tracking_system_app/modules/home/view/home_view.dart';
import 'package:tracking_system_app/modules/notifactions/view/notifaction_view.dart';
import 'package:tracking_system_app/modules/orders/view/orders_view.dart';
import 'package:tracking_system_app/modules/profile/view/profile_view.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const OrdersView(),
    const NotifactionView(),
     ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    "Home",
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
//Orders
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
                    "Orders",
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
            // Notifactions
            GestureDetector(
              onTap: () => _onItemTapped(2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications,
                    // Icons.restaurant_outlined,
                    size: 24,
                    color: _selectedIndex != 2
                        ? Theme.of(context).hintColor
                        : const Color(0xFF51946C),
                  ),
                  SizedBox(height: AppSizeH.s4),
                  Text(
                    "Notifactions",
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

            // Profile
            GestureDetector(
              onTap: () => _onItemTapped(3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.contact_page_rounded,
                    // Icons.person_outline,
                    size: 24,
                    color: _selectedIndex != 3
                        ? Theme.of(context).hintColor
                        : const Color(0xFF51946C),
                  ),
                  SizedBox(height: AppSizeH.s4),
                  Text(
                    "Profile",
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
