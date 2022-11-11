class FoodDrink {
  late String name;

  FoodDrink({
    required this.name,
  });

  FoodDrink.fromJson(Map<String, dynamic> food) {
    name = food['name'];
  }
}
