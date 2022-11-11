import 'package:dicoding_bfaf_submission/data/api/api_service.dart';
import 'package:dicoding_bfaf_submission/data/model/restaurant.dart';
import 'package:dicoding_bfaf_submission/utils/result_state.dart';
import 'package:flutter/material.dart';

class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  List<Restaurant> get result => _restaurant;
  late List<Restaurant> _restaurant;

  ResultState? get state => _state;
  late ResultState _state;

  String get message => _message;
  String _message = '';

  ListRestaurantProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      _message = 'Loading data';
      notifyListeners();
      final restaurant = await apiService.getList();

      if (restaurant.isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        _restaurant = restaurant;
      }

      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Something problem and Try again later';
      notifyListeners();
    }
  }
}
