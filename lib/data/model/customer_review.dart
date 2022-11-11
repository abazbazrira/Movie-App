class CustomerReview {
  late String name;
  late String review;
  late String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  CustomerReview.fromJson(Map<String, dynamic> customerReview) {
    name = customerReview['name'];
    review = customerReview['review'];
    date = customerReview['date'];
  }
}
