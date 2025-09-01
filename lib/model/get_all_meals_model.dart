  class GetAllMealsModel {
  final List<MealModel> meals;

  GetAllMealsModel({required this.meals});

  factory GetAllMealsModel.fromJson(Map<String, dynamic> json) {
    return GetAllMealsModel(
      meals: (json['meal'] as List<dynamic>)
          .map((item) => MealModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meal': meals.map((meal) => meal.toJson()).toList(),
    };
  }
}

class MealModel {
  final int id;
  final String name;
  final String description;
  final String ingredients;
  final String mealType;
  final int isActive;
  final List<String> imgs;

  MealModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.mealType,
    required this.isActive,
    required this.imgs,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      ingredients: json['ingredients'] as String,
      mealType: json['meal_type'] as String,
      isActive: json['is_active'] as int,
      imgs: List<String>.from(json['imgs'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'meal_type': mealType,
      'is_active': isActive,
      'imgs': imgs,
    };
  }
}
