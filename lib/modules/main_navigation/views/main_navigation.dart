import 'package:flutter/material.dart';
import 'package:tracking_system_app/modules/home/view/home_view.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static  List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    SelectMealsScreen (),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFA),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFE8F2EC),
              width: 1,
            ),
          ),
          color: Color(0xFFF8FBFA),
        ),
        padding: EdgeInsets.fromLTRB(AppSizeW.s16, AppSizeH.s8, AppSizeW.s16, AppSizeH.s12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home
            GestureDetector(
              onTap: () => _onItemTapped(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home_filled,
                    size: 24,
                    color: _selectedIndex == 0
                        ? const Color(0xFF0E1A13)
                        : const Color(0xFF51946C),
                  ),
                  SizedBox(height: AppSizeH.s4),
                  Text(
                    "Home",
                    style: TextStyle(
                      color: _selectedIndex == 0
                          ? const Color(0xFF0E1A13)
                          : const Color(0xFF51946C),
                      fontSize: AppSizeSp.s12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.015,
                    ),
                  ),
                ],
              ),
            ),

            // Meals
            GestureDetector(
              onTap: () => _onItemTapped(1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications,
                    // Icons.restaurant_outlined,
                    size: 24,
                    color: _selectedIndex == 1
                        ? const Color(0xFF0E1A13)
                        : const Color(0xFF51946C),
                  ),
                  SizedBox(height: AppSizeH.s4),
                  Text(
                    "Meals",
                    style: TextStyle(
                      color: _selectedIndex == 1
                          ? const Color(0xFF0E1A13)
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
              onTap: () => _onItemTapped(2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.contact_page_rounded,
                    // Icons.person_outline,
                    size: 24,
                    color: _selectedIndex == 2
                        ? const Color(0xFF0E1A13)
                        : const Color(0xFF51946C),
                  ),
                  SizedBox(height: AppSizeH.s4),
                  Text(
                    "Profile",
                    style: TextStyle(
                      color: _selectedIndex == 2
                          ? const Color(0xFF0E1A13)
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

class SelectMealsScreen extends StatefulWidget {
  const SelectMealsScreen({super.key});

  @override
  State<SelectMealsScreen> createState() => _SelectMealsScreenState();
}

class _SelectMealsScreenState extends State<SelectMealsScreen> {
  final List<Meal> meals = [
    Meal(
      name: 'Mediterranean Quinoa Bowl',
      description: 'Quinoa, feta, olives, tomatoes, cucumber, lemon vinaigrette',
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
      description: 'Chicken breast, mixed vegetables, brown rice, soy ginger sauce',
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
      description: 'Turkey meatballs, zucchini noodles, marinara sauce, parmesan',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fbfa),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: AppSizeW.s4,
              right: AppSizeW.s4,
              top: AppSizeH.s4,
              bottom: AppSizeH.s2),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  iconSize: AppSizeSp.s24,
                  color: const Color(0xFF0e1a13),
                  onPressed: () {},
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppSizeW.s12),
                    child: Text(
                      'Select Meals',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF0e1a13),
                        fontSize: AppSizeSp.s18,
                        fontWeight: FontWeight.bold,
                        height: AppSizeH.s1,
                        letterSpacing: AppSizeSp.s15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSizeW.s4,
                vertical: AppSizeH.s3),
            child: Text(
              'Choose up to 2 meals per delivery day',
              style: TextStyle(
                color: const Color(0xFF0e1a13),
                fontSize: AppSizeSp.s22,
                fontWeight: FontWeight.bold,
                height: AppSizeH.s1,
                letterSpacing: AppSizeSp.s15,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(AppSizeW.s4),
                  child: MealItem(
                    meal: meals[index],
                    onTap: () => toggleMealSelection(index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: AppSizeH.s3,
                top: AppSizeH.s1,
                left: AppSizeW.s4,
                right: AppSizeW.s4),
            child: Text(
              selectedMealsCount > 2
                  ? 'You have selected $selectedMealsCount meals. Please remove one to proceed.'
                  : 'You have selected $selectedMealsCount meals.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF51946c),
                fontSize: AppSizeSp.s14,
                fontWeight: FontWeight.normal,
                height: AppSizeH.s1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSizeW.s4,
                vertical: AppSizeH.s3),
            child: SizedBox(
              width: double.infinity,
              height: AppSizeH.s12,
              child: ElevatedButton(
                onPressed: selectedMealsCount <= 2 ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF38e07b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizeR.s12),
                  ),
                ),
                child: Text(
                  'Confirm Selection',
                  style: TextStyle(
                    color: const Color(0xFF0e1a13),
                    fontSize: AppSizeSp.s16,
                    fontWeight: FontWeight.bold,
                    height: AppSizeH.s1,
                    letterSpacing: AppSizeSp.s15,
                  ),
                ),
              ),
            ),
          ),
          
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  style: TextStyle(
                    color: const Color(0xFF0e1a13),
                    fontSize: AppSizeSp.s16,
                    fontWeight: FontWeight.bold,
                    height: AppSizeH.s1,
                  ),
                ),
                SizedBox(height: AppSizeH.s1),
                Text(
                  meal.description,
                  style: TextStyle(
                    color: const Color(0xFF51946c),
                    fontSize: AppSizeSp.s14,
                    fontWeight: FontWeight.normal,
                    height: AppSizeH.s1,
                  ),
                ),
                SizedBox(height: AppSizeH.s4),
                SizedBox(
                  height: AppSizeH.s8,
                  child: ElevatedButton.icon(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: meal.isSelected
                          ? const Color(0xFF51946c)
                          : const Color(0xFFe8f2ec),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizeR.s8),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizeW.s4),
                      minimumSize: Size(AppSizeW.s80, AppSizeH.s0),
                    ),
                    icon: Icon(
                      meal.isSelected ? Icons.check : Icons.add,
                      size: AppSizeSp.s18,
                      color: const Color(0xFF0e1a13),
                    ),
                    label: Text(
                      meal.isSelected ? 'Added' : 'Add',
                      style: TextStyle(
                        color: const Color(0xFF0e1a13),
                        fontSize: AppSizeSp.s14,
                        fontWeight: FontWeight.w500,
                        height: AppSizeH.s1,
                      ),
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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(
          color: Color(0xFF0E1A13),
          fontSize: AppSizeSp.s24,
        ),
      ),
    );
  }
}