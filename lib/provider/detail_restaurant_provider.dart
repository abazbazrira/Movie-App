import 'package:dicoding_bfaf_submission/data/api/api_service.dart';
import 'package:dicoding_bfaf_submission/data/model/restaurant.dart';
import 'package:dicoding_bfaf_submission/utils/result_state.dart';
import 'package:flutter/material.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  Restaurant get result => _restaurant;
  late Restaurant _restaurant;

  String get message => _message;
  String _message = '';

  ResultState? get state => _state;
  late ResultState _state;

  DetailRestaurantProvider(
      {required this.apiService, required this.restaurantId}) {
    _fetchRestaurant();
  }

  Future<dynamic> _fetchRestaurant() async {
    try {
      _state = ResultState.loading;
      _message = 'Loading data';
      notifyListeners();

      final restaurant = await apiService.getDetail(restaurantId);

      if (restaurant.id.isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty Data';
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _restaurant = restaurant;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Something problem and Try again later';
    }
  }
}
