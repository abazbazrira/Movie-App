import 'package:dicoding_mfde_submission/data/db/database_helper.dart';
import 'package:dicoding_mfde_submission/provider/database_provider.dart';
import 'package:dicoding_mfde_submission/ui/detail_restaurant_page.dart';
import 'package:dicoding_mfde_submission/utils/notification_helper.dart';
import 'package:dicoding_mfde_submission/utils/result_state.dart';
import 'package:dicoding_mfde_submission/widgets/error_state_widget.dart';
import 'package:dicoding_mfde_submission/widgets/item_restaurant_widget.dart';
import 'package:dicoding_mfde_submission/widgets/loading_state_widget.dart';
import 'package:dicoding_mfde_submission/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteRestaurantPage extends StatefulWidget {
  static const routeName = '/favorite_restaurant';

  const FavoriteRestaurantPage({Key? key}) : super(key: key);

  @override
  _FavoriteRestaurantPageState createState() => _FavoriteRestaurantPageState();
}

class _FavoriteRestaurantPageState extends State<FavoriteRestaurantPage> {
  final String title = 'Favorite';

  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailRestaurantPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseProvider>(
      create: (_) => DatabaseProvider(
        databaseHelper: DatabaseHelper(),
      ),
      child: PlatformWidget(
        androidBuilder: _androidBuilder(context),
        iosBuilder: _iosBuilder(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, value, _) {
        if (value.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: value.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = value.restaurants[index];
              return ItemRestaurantWidget(restaurant: restaurant);
            },
          );
        } else if (value.state == ResultState.loading) {
          return LoadingStateWidget(message: value.message);
        } else if (value.state == ResultState.noData) {
          return ErrorStateWidget(message: value.message);
        } else if (value.state == ResultState.error) {
          return ErrorStateWidget(message: value.message);
        } else {
          return const ErrorStateWidget(
            message: 'Something problem. Try again later.',
          );
        }
      },
    );
  }

  Widget _androidBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _iosBuilder(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          title,
        ),
      ),
      child: _buildList(context),
    );
  }
}
