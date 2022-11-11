import 'dart:io';

import 'package:dicoding_bfaf_submission/data/preference/preference_helper.dart';
import 'package:dicoding_bfaf_submission/provider/scheduling_provider.dart';
import 'package:dicoding_bfaf_submission/widgets/custom_dialog.dart';
import 'package:dicoding_bfaf_submission/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';
  static const String routeName = '/setting';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SchedulingProvider(
          preferenceHelper: PreferenceHelper(
              sharedPreferences: SharedPreferences.getInstance())),
      child: PlatformWidget(
        androidBuilder: _buildAndroid(context),
        iosBuilder: _buildIos(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: const Text('Dark Theme'),
            trailing: Switch.adaptive(
              value: false,
              onChanged: (value) => customDialog(context),
            ),
          ),
        ),
        Material(
          child: ListTile(
            title: const Text('Scheduling Restaurant'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isDailyRestaurantActive,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      scheduled.scheduledRestaurants(value);
                      scheduled.enableDailyRestaurant(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }
}
