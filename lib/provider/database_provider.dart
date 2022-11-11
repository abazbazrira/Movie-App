import 'package:dicoding_bfaf_submission/data/db/database_helper.dart';
import 'package:dicoding_bfaf_submission/data/model/restaurant.dart';
import 'package:dicoding_bfaf_submission/utils/result_state.dart';
import 'package:flutter/foundation.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  ResultState? get state => _state;
  late ResultState _state;

  String get message => _message;
  String _message = '';

  List<Restaurant> get restaurants => _restaurants;
  List<Restaurant> _restaurants = [];

  DatabaseProvider({required this.databaseHelper}) {
    _getBookmarks();
  }

  void addBookmark(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  void _getBookmarks() async {
    _state = ResultState.loading;
    _message = 'Loading data';
    notifyListeners();
    _restaurants = await databaseHelper.getRestaurants();

    if (_restaurants.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  Future<bool> isBookmarked(String id) async {
    final restaurantFavorite = await databaseHelper.getRestaurantById(id);
    return restaurantFavorite.isNotEmpty;
  }

  void removeBookmark(String url) async {
    try {
      await databaseHelper.removeFavorite(url);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
