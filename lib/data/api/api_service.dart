import 'dart:convert';

import 'package:dicoding_bfaf_submission/data/model/restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _getList = 'list';
  static const String _getDetail = 'detail';
  static const String _getSearch = 'search';

  Future<List<Restaurant>> getList() async {
    final response = await http
        .get(Uri.parse('$_baseUrl/$_getList'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return listRestaurants(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Restaurant> getDetail(String restaurantId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/$_getDetail/$restaurantId'));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(jsonDecode(response.body)['restaurant']);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Restaurant>> getSearch(String query) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/$_getSearch?q=$query'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return listRestaurants(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
