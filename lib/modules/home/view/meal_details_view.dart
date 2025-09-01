import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/model/get_all_meals_model.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class MealDetailsView extends StatelessWidget {
  final MealModel meal;
  const MealDetailsView({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            stretch: true,
            backgroundColor: AppVar.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                meal.name,
                style: TextStyle(
                  fontSize: AppSizeSp.s18,
                  fontWeight: FontWeight.w600,
                  color: AppVar.seconndTextColor,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.6),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              background: Hero(
                tag: 'meal-${meal.id}',
                child: meal.imgs.isNotEmpty
                    ? Image.network(
                        "http://10.0.2.2:8000/${meal.imgs[0]}",
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            "assets/images/icon.png",
                            fit: BoxFit.cover,
                          );
                        },
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/icon.png",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(AppSizeW.s8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: AppSizeSp.s20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSizeW.s20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meal status and type chips
                  Row(
                    children: [
                      // Status chip
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSizeW.s12, vertical: AppSizeH.s6),
                        decoration: BoxDecoration(
                          color: meal.isActive == 1
                              ? Colors.green.withValues(alpha: 0.2)
                              : Colors.red.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(AppSizeR.s20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              meal.isActive == 1
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              size: AppSizeSp.s14,
                              color: meal.isActive == 1
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            SizedBox(width: AppSizeW.s6),
                            Text(
                              meal.isActive == 1 ? "Available" : "Unavailable",
                              style: TextStyle(
                                fontSize: AppSizeSp.s12,
                                fontWeight: FontWeight.w600,
                                color: meal.isActive == 1
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: AppSizeW.s10),

                      // Meal type chip
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSizeW.s12, vertical: AppSizeH.s6),
                        decoration: BoxDecoration(
                          color: AppVar.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(AppSizeR.s20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.restaurant,
                              size: AppSizeSp.s14,
                              color: AppVar.primary,
                            ),
                            SizedBox(width: AppSizeW.s6),
                            Text(
                              meal.mealType.toUpperCase(),
                              style: TextStyle(
                                fontSize: AppSizeSp.s12,
                                fontWeight: FontWeight.w600,
                                color: AppVar.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSizeH.s20),

                  // Description section
                  _buildSection(
                    context,
                    title: "Description",
                    icon: Icons.description,
                    child: Text(
                      meal.description,
                      style: TextStyle(
                        fontSize: AppSizeSp.s15,
                        color: isDark ? Colors.grey[300] : Colors.grey[700],
                        height: 1.6,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSizeH.s24),

                  // Ingredients section
                  _buildSection(
                    context,
                    title: "Ingredients",
                    icon: Icons.restaurant_menu,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (meal.ingredients.isNotEmpty)
                          ...meal.ingredients.split(',').map((ingredient) =>
                              _buildIngredientItem(ingredient.trim()))
                        else
                          Text(
                            "No ingredients listed",
                            style: TextStyle(
                              fontSize: AppSizeSp.s14,
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSizeH.s24),

                  // Nutritional info (if available)
                  _buildSection(
                    context,
                    title: "Nutritional Information",
                    icon: Icons.monitor_heart,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNutritionItem(
                            "Calories", "350", Icons.local_fire_department),
                        _buildNutritionItem(
                            "Protein", "25g", Icons.fitness_center),
                        _buildNutritionItem("Carbs", "45g", Icons.grain),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSizeH.s40),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Obx(() {
        final isSelected = homeController.selectedMealIds.contains(meal.id);

        return SizedBox(
          height: AppSizeH.s40, // control height
          width: AppSizeW.s180, // control width
          child: ElevatedButton.icon(
            onPressed: () {
              homeController.toggleMealSelection(meal.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected
                  ? AppVar.primarySoft
                  : Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizeR.s8),
              ),
              padding: EdgeInsets.symmetric(horizontal: AppSizeW.s10),
            ),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isSelected ? 'Added' : "Add to Selection",
                  style: TextStyle(
                    color: isSelected
                        ? AppVar.seconndTextColor
                        : Theme.of(context).disabledColor,
                    fontSize: AppSizeSp.s14,
                    fontWeight: FontWeight.w500,
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
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required IconData icon, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppVar.primary,
              size: AppSizeSp.s20,
            ),
            SizedBox(width: AppSizeW.s10),
            Text(
              title,
              style: TextStyle(
                fontSize: AppSizeSp.s18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSizeH.s12),
        Container(
          padding: EdgeInsets.all(AppSizeW.s16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppSizeR.s12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildIngredientItem(String ingredient) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizeH.s6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.circle,
            size: AppSizeSp.s8,
            color: AppVar.primary,
          ),
          SizedBox(width: AppSizeW.s12),
          Expanded(
            child: Text(
              ingredient,
              style: TextStyle(
                fontSize: AppSizeSp.s14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(AppSizeW.s10),
          decoration: BoxDecoration(
            color: AppVar.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppVar.primary,
            size: AppSizeSp.s20,
          ),
        ),
        SizedBox(height: AppSizeH.s8),
        Text(
          value,
          style: TextStyle(
            fontSize: AppSizeSp.s16,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: AppSizeH.s4),
        Text(
          title,
          style: TextStyle(
            fontSize: AppSizeSp.s12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
