import 'dart:convert';
import 'dart:math';

import 'package:dicoding_mfde_submission/common/navigation.dart';
import 'package:dicoding_mfde_submission/data/model/restaurant.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationSubject
                .add(notificationResponse.payload.toString());
            break;
          case NotificationResponseType.selectedNotificationAction:
            selectNotificationSubject
                .add(notificationResponse.payload.toString());
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse:
          (NotificationResponse notificationResponse) {
        // ignore: avoid_print
        print('notification(${notificationResponse.id}) action tapped: '
            '${notificationResponse.actionId} with'
            ' payload: ${notificationResponse.payload}');
        if (notificationResponse.input?.isNotEmpty ?? false) {
          // ignore: avoid_print
          print(
              'notification action tapped with input: ${notificationResponse.input}');
        }
      }, // onSelectNotification: (String? payload) async {
      //   if (payload != null) {
      //     print('notification payload: ' + payload);
      //   }
      //   selectNotificationSubject.add(payload ?? 'empty payload');
      // },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      List<Restaurant> restaurants) async {
    var _channelId = '1';
    var _channelName = 'channel_01';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = '<b>Restaurant</b>';
    var index =
        restaurants.length > 1 ? Random().nextInt(restaurants.length) : 0;
    var titleRestaurants = restaurants[index].name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurants, platformChannelSpecifics,
        payload: json.encode(restaurants[index].toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        Navigation.intentWithData(
          route,
          Restaurant.fromJson(json.decode(payload)),
        );
      },
    );
  }
}
