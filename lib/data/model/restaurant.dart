import 'dart:convert';

import 'package:dicoding_bfaf_submission/data/model/category.dart';
import 'package:dicoding_bfaf_submission/data/model/customer_review.dart';
import 'package:dicoding_bfaf_submission/data/model/menu.dart';
import 'package:dicoding_bfaf_submission/utils/set_default_value.dart';

class BaseResponse {
  late bool? error;
  late String? message;

  BaseResponse({
    required this.error,
    required this.message,
  });
}

class RestaurantResponse extends BaseResponse {
  late Restaurant restaurant;
  late int? count;

  RestaurantResponse({
    required bool error,
    required String message,
    required this.count,
    required this.restaurant,
  }) : super(error: error, message: message);
}

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late num rating;
  late Menu? menu;
  late List<CustomerReview>? customerReviews;
  late List<Categories>? categories;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menu,
    required this.customerReviews,
    required this.categories,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = checkStringIsNull(restaurant['id']);
    name = checkStringIsNull(restaurant['name']);
    description = checkStringIsNull(restaurant['description']);
    pictureId = checkStringIsNull(restaurant['pictureId']);
    city = checkStringIsNull(restaurant['city']);
    rating = checkNumIsNull(restaurant['rating']);
    menu = (restaurant['menus'] != null)
        ? Menu.fromJson(restaurant['menus'])
        : null;
    city = checkStringIsNull(restaurant['city']);
    customerReviews = (restaurant['customerReviews'] != null)
        ? List<CustomerReview>.from(restaurant['customerReviews']
            .map((x) => CustomerReview.fromJson(x)))
        : null;
    categories = (restaurant['categories'] != null)
        ? List<Categories>.from(
            restaurant['categories'].map(
              (x) => Categories.fromJson(x),
            ),
          )
        : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}

Map<String, dynamic> listRestaurantToJson(List<Restaurant> restaurants) => {
      "restaurants": List<dynamic>.from(restaurants.map((e) => e.toJson())),
    };

List<Restaurant> listRestaurants(dynamic json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
