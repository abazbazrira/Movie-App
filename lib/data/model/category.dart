class Categories {
  late String? name;

  Categories({
    required this.name,
  });

  Categories.fromJson(Map<String, dynamic> customerReview) {
    name = customerReview['name'];
  }
}
