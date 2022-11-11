import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_bfaf_submission/data/preference/preference_helper.dart';
import 'package:dicoding_bfaf_submission/utils/background_service.dart';
import 'package:dicoding_bfaf_submission/utils/date_time_helper.dart';
import 'package:flutter/material.dart';

class SchedulingProvider extends ChangeNotifier {
  final PreferenceHelper preferenceHelper;

  bool get isScheduled => _isScheduled;
  bool _isScheduled = false;

  bool get isDailyRestaurantActive => _isDailyRestaurantActive;
  bool _isDailyRestaurantActive = false;

  SchedulingProvider({required this.preferenceHelper}) {
    _getDailyRestaurantPreferences();
  }

  Future<bool> scheduledRestaurants(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Restaurants Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(days: 1),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Restaurants Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }

  void _getDailyRestaurantPreferences() async {
    _isDailyRestaurantActive = await preferenceHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDailyRestaurant(bool value) {
    preferenceHelper.setDailyRestaurant(value);
    _getDailyRestaurantPreferences();
  }
}
