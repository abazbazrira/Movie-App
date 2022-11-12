import 'package:dicoding_mfde_submission/data/model/food_drink.dart';

class Menu {
  late List<FoodDrink> foods;
  late List<FoodDrink> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  Menu.fromJson(Map<String, dynamic> menu) {
    if (menu['foods'] != null) {
      foods =
          List<FoodDrink>.from(menu['foods'].map((x) => FoodDrink.fromJson(x)));
    }

    if (menu['drinks'] != null) {
      drinks = List<FoodDrink>.from(
          menu['drinks'].map((x) => FoodDrink.fromJson(x)));
    }
  }
}
